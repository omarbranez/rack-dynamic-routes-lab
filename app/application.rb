require 'pry' # why do none of these labs require pry?
class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_term = req.path.split("/items/").last
            #req.path gets us "'/items/Figs'". we need Figs for our query
            #after splitting, Figs is the last element of the array
            search = @@items.find {|item| item.name == search_term} #each do kept printing 400 errors
            if search == nil 
                resp.status = 400
                resp.write "Item not found"
            else
                resp.write "#{search.price}" #item.price, but search is the object Figs
            end            
        else #if it's anything BUT /items/
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end
end