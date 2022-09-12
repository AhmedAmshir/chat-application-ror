class ErrorController < ApplicationController

    def self.invalid_token()
        return "Error: invalid application token"
    end

    def self.invalid_chat_number()
        return "Error: invalid chat number or application token"
    end

    def self.invalid_message_number()
        return "Error: invalid message number"
    end

end