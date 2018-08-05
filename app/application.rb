require "pry"

class Application

  def call (env)
    resp = Rack::Response.new
    req = Rack::Request.new (env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last

    item_match = @@items.find do |item|
       item.name == item_name
      end
      if item_match.nil?
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write item_match.price
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
