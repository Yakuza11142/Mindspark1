import { serve } from "https://deno.land"
import { crypto } from "https://deno.land"

serve(async (req) => {
  // Gracefully block non-POST operations from hitting execution threads
  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({ success: false, error: "Method Not Allowed" }), 
      { status: 405, headers: { "Content-Type": "application/json" } }
    );
  }

  try {
    // Unpack variables from the inbound client application context
    const { name, course, hw_id } = await req.json();
    
    // Validate structural client parameter configurations before initiating hash algorithms
    if (!name || !course || !hw_id) {
      return new Response(
        JSON.stringify({ success: false, error: "Missing required identification metadata strings" }), 
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // FIXED: ZERO HARDCODING. Pull the absolute cryptographic salt string 
    // exclusively from the secure cloud environment variable management layers.
    const secretSalt = Deno.env.get("PRODUCTION_SECRET_SALT");
    
    // STRICT SECURITY GATE: Force the cloud engine to immediately crash out the request 
    // if the server variable is unmapped. Never allow a silent fallback to process certificates.
    if (!secretSalt) {
      console.error("🚨 CRITICAL SECURITY FAULT: PRODUCTION_SECRET_SALT environment variable is unmapped.");
      return new Response(
        JSON.stringify({ success: false, error: "Internal Server Configuration Lock" }), 
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // Fetch authoritative cloud atomic clock time to bypass client mobile clock-tampering
    const serverTimestamp = new Date().toISOString();

    // Construct the immutable data validation block
    const rawPayload = `${name.trim()}|${course.trim()}|${hw_id.trim()}|${serverTimestamp}|${secretSalt}`;
    const encoder = new TextEncoder();
    const dataBuffer = encoder.encode(rawPayload);

    // Compute hardware-accelerated dual secure SHA cryptographic hashes on the backend cluster
    const hashBuffer256 = await crypto.subtle.digest("SHA-256", dataBuffer);
    const hashBuffer512 = await crypto.subtle.digest("SHA-512", dataBuffer);

    // Convert binary stream chunks back to clean hexadecimal string formats for database tracking
    const sha256Hex = Array.from(new Uint8Array(hashBuffer256)).map(b => b.toString(16).padStart(2, "0")).join("");
    const sha512Hex = Array.from(new Uint8Array(hashBuffer512)).map(b => b.toString(16).padStart(2, "0")).join("");

    return new Response(
      JSON.stringify({
        success: true,
        hash_256: sha256Hex,
        hash_512: sha512Hex,
        verified_at: serverTimestamp
      }),
      { status: 200, headers: { "Content-Type": "application/json" } }
    );

  } catch (error) {
    console.error(`🚨 Fatal Script Processing Loop Abort: ${error.message}`);
    return new Response(
      JSON.stringify({ success: false, error: "Cryptographic signature processing cycle failed safely." }), 
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});
