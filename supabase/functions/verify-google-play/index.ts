import { serve } from "https://deno.land"
import { createClient } from "https://esm.sh"

// Simple minimal structure for OAuth authentication token negotiation
async function getGoogleAccessToken(clientEmail: string, privateKey: string): Promise<string> {
  const header = { alg: "RS256", typ: "JWT" };
  const now = Math.floor(Date.now() / 1000);
  
  const payload = {
    iss: clientEmail,
    scope: "https://www.googleapis.com/auth/androidpublisher",
    aud: "https://googleapis.com",
    exp: now + 3600,
    iat: now
  };

  // Convert keys and create an assertion token to request an Access Token from Google
  // For production environments, use standard npm compatibility layers or standard JWT wrappers
  const response = await fetch("https://googleapis.com", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: "GENERATED_SIGNED_JWT_STRING_OR_USE_LIBRARY" 
    })
  });
  
  const data = await response.json();
  return data.access_token;
}

serve(async (req) => {
  try {
    const { purchase_token, product_id, package_name } = await req.json();
    
    // 1. Authenticate with Supabase client using Service Role token to bypass database RLS constraints
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    );

    // 2. Extract calling user information from request authorization headers
    const authHeader = req.headers.get('Authorization')!;
    const { data: { user }, error: authError } = await supabaseAdmin.auth.getUser(
      authHeader.replace('Bearer ', '')
    );
    if (authError || !user) return new Response("Unauthorized", { status: 401 });

    // 3. Fetch Google Service credentials safely stored in Edge vault secrets
    const googleEmail = Deno.env.get('GOOGLE_SERVICE_ACCOUNT_EMAIL')!;
    const googleKey = Deno.env.get('GOOGLE_PRIVATE_KEY')!.replace(/\\n/g, '\n');

    // 4. Request validation token handshake from Google Android Publisher API
    const googleToken = await getGoogleAccessToken(googleEmail, googleKey);
    const googleUrl = `https://googleapis.com{package_name}/purchases/subscriptions/${product_id}/tokens/${purchase_token}`;

    const verificationResponse = await fetch(googleUrl, {
      headers: { Authorization: `Bearer ${googleToken}` }
    });

    const purchaseData = await verificationResponse.json();

    // 5. Inspect subscription expiry time parameter logic
    const expiryTimeMillis = parseInt(purchaseData.expiryTimeMillis ?? "0");
    const isSubscriptionActive = expiryTimeMillis > Date.now();

    if (isSubscriptionActive) {
      // Upgrade database table record fields using the administrator client bypassing rules
      await supabaseAdmin
        .from('profiles')
        .update({
          is_pro: true,
          pro_updated_at: new Date().toISOString()
        })
        .eq('id', user.id);

      return new Response(JSON.stringify({ success: true, message: "Upgraded!" }), { status: 200 });
    }

    return new Response(JSON.stringify({ success: false, message: "Subscription expired." }), { status: 400 });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
})
