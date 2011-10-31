# coding: utf-8
TARGET_DIR = "/app/assets/entries/"
NEW_FILE_CONTENT = <<"EOS"
title: new file
slug: new-file

### 新しいタイトル

新しい文章
EOS

namespace :blog do
  desc "新しくブログを作成する"
  task :new do
    today = Time.now
    new_file_name = "#{today.year}-#{today.month}-#{today.day}-new-file.mkd"
    begin
      File.open(Dir::pwd + TARGET_DIR + new_file_name, "w"){|f| f.write NEW_FILE_CONTENT}
      puts "Created new blog entry : "
      puts "  #{TARGET_DIR + new_file_name}"
    rescue => e
      puts "Cannot create new blog entry : "
      puts "  #{e}"
    end
  end
end
