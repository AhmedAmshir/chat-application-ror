task :elastic_launch => [:environment] do

    if !Message.all.empty?
        Message.__elasticsearch__.create_index!
        Message.__elasticsearch__.refresh_index!
    end
end