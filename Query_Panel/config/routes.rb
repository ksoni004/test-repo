QueryPanel::Application.routes.draw do
  
  get '/generate_query' => "queries#generate_query"

  post '/query_generated' => "queries#query_generated"

  get '/resolve_query' => "queries#resolve_query"
  
  get '/query_table' => "queries#query_table"

  post '/close' => "queries#close"

  post '/follow_up' => "queries#follow_up"
  
end
