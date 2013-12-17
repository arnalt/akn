require "spec_helper"

describe ReportsController do
  describe "routing" do

    it "routes to #input" do
      get("/reports/input").should route_to("reports#input")
    end

    it "routes to #excel" do
      get("/reports/excel").should route_to("reports#excel")
    end

    it "routes to #output" do
      get("/reports/output").should route_to("reports#output")
    end

    it "routes to #sel" do
      get("/reports/sel").should route_to("reports#sel")
    end

    it "routes to #output" do
     post("/reports/output").should route_to("reports#output")
    end

    it "routes to #output_pdf" do
      post("/reports/output_pdf").should route_to("reports#output_pdf")
    end

    it "routes to #pdf" do
      get("/reports/pdf").should route_to("reports#pdf")
    end

  end
end

