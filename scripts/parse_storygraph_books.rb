require "csv"
require "net/http"
require "yaml"

def parse_storygraph_csv(file_path)
  books = CSV.read(file_path)
  filtered = books.select { |book| book[5] == "read" || book[5] == "currently-reading" || book[5] == "did-not-finish" }
  output = Array.new(filtered.length)
  for i in 0...filtered.length
    book = filtered[i]
    output[i] = { "title" => book[0], "authors" => book[1], "isbn" => book[3], "status" => book[5], "date_read" => book[6], "owned" => book[22] == "Yes" }
  end
  return output
end

books = parse_storygraph_csv(ARGV[0])
File.write("./src/_data/books.yml", books.to_yaml)
