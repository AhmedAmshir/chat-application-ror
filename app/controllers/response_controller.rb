class ResponseController < ApplicationController

    def self.success(data)
        return {:data => data, :status_code => 200, :message => ''}
    end

    def self.error(chat_number)
    end

end