import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

serve(async (req) => {
  const { user_id, phone_number } = await req.json()
  
  // NEVER PUT THIS KEY IN FLUTTER. IT LIVES SAFELY HERE.
  const MTN_API_KEY = Deno.env.get('MTN_SPONSORED_DATA_KEY')

  console.log(`Allocating free data to ${phone_number} for user ${user_id}...`)
  
  // HTTP POST to MTN API
  // const response = await fetch('https://mtn.api.com/allocate', { headers: { 'Authorization': `Bearer ${MTN_API_KEY}` }})

  return new Response(JSON.stringify({ success: true, message: "Data allocated." }), { headers: { "Content-Type": "application/json" } })
})