Jets.application.routes.draw do
  root "jets/public#show"
  resources :items, only: [:index, :show] do
    member do
      post 'maintain'
    end
  end
  delete 'items/:item_id/maintenances/:maintenance_id', to: 'maintenances#destroy'
  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
