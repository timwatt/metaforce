require "spec_helper"

describe Metaforce::Services::Client do
  describe ".login" do
    context "when given invalid credentials" do

      it "raises an error" do
        savon.expects(:login).with(:username => 'invalid', :password => 'password').returns(:failure)
        expect { Metaforce::Services::Client.new(:username => 'invalid', :password => 'password') }.to raise_error
      end

    end
    context "when given valid credentials" do

      it "returns a hash containing the session id and metadata server url" do
        savon.expects(:login).with(:username => 'valid', :password => 'password').returns(:success)
        session = Metaforce::Services::Client.new(:username => 'valid', :password => 'password').session
        session.should eq({ :session_id => "00DU0000000Ilbh!AQoAQHVcube9Z6CRlbR9Eg8ZxpJlrJ6X8QDbnokfyVZItFKzJsLHIRGiqhzJkYsNYRkd3UVA9.s82sbjEbZGUqP3mG6TP_P8",
                            :metadata_server_url => "https://na12-api.salesforce.com/services/Soap/m/23.0/00DU0000000Albh" })
      end

    end
    context "when given a hash with strings" do
      it "works just like symbols" do
        savon.expects(:login).with(:username => 'valid', :password => 'password').returns(:success)
        session = Metaforce::Services::Client.new("username" => 'valid', "password" => 'password').session
        session.should eq({ :session_id => "00DU0000000Ilbh!AQoAQHVcube9Z6CRlbR9Eg8ZxpJlrJ6X8QDbnokfyVZItFKzJsLHIRGiqhzJkYsNYRkd3UVA9.s82sbjEbZGUqP3mG6TP_P8",
                            :metadata_server_url => "https://na12-api.salesforce.com/services/Soap/m/23.0/00DU0000000Albh" })
      end
    end
  end
end
