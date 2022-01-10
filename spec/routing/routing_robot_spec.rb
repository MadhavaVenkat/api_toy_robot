require 'rspec-rails'
RSpec.describe "Routing robots", type: :routing do
  describe "route to command action" do
    it "has valid route" do
      expect(get: "/api/robot/0/orders").to route_to("api/robot/orders#command")
    end
  end
end