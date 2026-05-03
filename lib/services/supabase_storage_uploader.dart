// supabase/functions/upload-avatar/index.ts
import { serve } from "https://deno.land"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Get the user ID from the request (e.g., from a custom header or the auth token)
    const userId = req.headers.get('x-user-id');
    const contentType = req.headers.get('content-type') || 'image/jpeg';
    
    if (!userId) throw new Error('Missing User ID');

    // Read the binary body directly
    const arrayBuffer = await req.arrayBuffer();
    const path = `avatars/${userId}.jpg`;

    const { data, error } = await supabase.storage
      .from('public_assets')
      .upload(path, arrayBuffer, {
        contentType: contentType,
        upsert: true
      });

    if (error) throw error;

    const { data: { publicUrl } } = supabase.storage
      .from('public_assets')
      .getPublicUrl(path);

    return new Response(JSON.stringify({ url: publicUrl }), { 
      headers: { "Content-Type": "application/json" } 
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 });
  }
})
