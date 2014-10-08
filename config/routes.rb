Bloccit::Application.routes.draw do
  get "welcome/index"
  get "welcome/about"

  root to: "welcome#index"
  # could also be written as:
  # root({to: "welcome#index"}) // example of an implied hash.
end
