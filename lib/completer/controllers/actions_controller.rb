::Completer::Application.controller :actions do

  # Complete snippet path
  post :complete, :provides => :json do
    begin
      res = social_snippet.api.complete_snippet_path(params[:q])
      {
        :status => "OK",
        :result => res,
      }.to_json
    rescue => e
      {
        :status => "ERROR",
        :error => e.to_s,
      }.to_json
    end
  end

  # Install repository
  post :install, :provides => :json do
    params[:repos].each do |repo_name|
      social_snippet.api.install_repository_by_name repo_name, nil
    end
    {
      :status => "OK",
    }.to_json
  end

  # Insert snippets
  post :insert, :provides => :json do
    res = social_snippet.api.insert_snippet(params[:text])
    {
      :status => "OK",
      :text => res,
    }
  end

end