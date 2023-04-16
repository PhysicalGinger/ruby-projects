require "sinatra"
require "cgi"
def page_content(title)
    File.read("pages/#{title}.txt")
rescue Errno::ENOENT
    return nil
end

def save_content(title, content)
    File.open("pages/#{title}.txt", "w") do |file|
        file.print(content)
    end
end

def delete_content(title)
    File.delete("pages/#{title}.txt")
end

def h(string)
    Rack::Utils.escape_html(string)
  end

get "/" do
    erb :welcome
end

get "/new" do
    erb :new
end

get "/:title" do
    @title = params[:title] 
    @content = page_content(@title)
    erb :show
end

get "/:title/edit" do
    @title = params[:title]
    @content = page_content(@title)
    erb :edit
end


post "/create" do
    @title = params["title"]
    @content = params["content"]
    save_content(@title, @content)
    @escaped_title = URI.encode_www_form_component("/#{@title}")
    if @escaped_title.include? "+"
        @escaped_title.sub("+", " ")
    end
   redirect "/#{@title}"
end

put "/:title" do
    @title = params["title"]
    @content = params["content"]
    save_content(@title, @content)
    @escaped_title = URI.encode_www_form_component("/#{@title}")
    if @escaped_title.include? "+"
        @escaped_title.sub("+", " ")
    end
   redirect "/#{@title}"
end

delete "/:title" do
    @title = params["title"]
    delete_content(@title)

    redirect "/"
end
