import { createClient } from 'jsr:@supabase/supabase-js@2'

Deno.serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Get the request body
    const { name, avatar_url, user_id } = await req.json()

    if (!user_id) throw new Error('User ID is required')

    const { data, error } = await supabase
      .from('profiles')
      .upsert({
        id: user_id,
        name,
        avatar_url,
        updated_at: new Date().toISOString(),
      })
      .select()

    if (error) throw error

    return new Response(JSON.stringify(data), { 
      headers: { "Content-Type": "application/json" } 
    })
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 })
  }
})
