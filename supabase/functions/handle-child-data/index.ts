import { serve } from "https://deno.land"

serve(async (req) => {
  const { email, password, age } = await req.json()

  console.log(`Processing sensitive minor data for: ${email}`)

  return new Response(
    JSON.stringify({ message: "Parental consent required to proceed." }),
    { headers: { "Content-Type": "application/json" }, status: 200 }
  )
})
