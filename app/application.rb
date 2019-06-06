class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = nil
      item_title = req.path.split("/items/").last  #turn /items/<ITEM NAME> into Item Name
      item = @@items.find{|i| i.name == item_title}
      if item != nil
        resp.write "#{item.price}"
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
