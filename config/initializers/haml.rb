BlogMahLabCom::Application.configure do
  config.after_initialize do
    # HTMLの自動インデントを無効にする
    Haml::Template::options[:ugly] = true
  end
end

