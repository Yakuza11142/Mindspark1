import { createClient } from 'jsr:@supabase/supabase-js@2'

Deno.serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Parse the JSON payload from the Flutter client
    const { exam_type, score, user_id, created_at } = await req.json()

    const { error } = await supabase
      .from('exam_results')
      .insert({ 
        user_id, 
        exam_type, 
        score, 
        created_at: created_at ?? new Date().toISOString() 
      })

    if (error) throw error

    return new Response(JSON.stringify({ success: true }), { 
      headers: { "Content-Type": "application/json" } 
    })
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 })
  }
})
