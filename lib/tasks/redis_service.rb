class RedisService

    def initialize
        @redis = REDIS
    end

    def set(key, value)
        @redis.set(key,value)
    end
    
    def get(key)
        @redis.get(key) 
    end
    
    def set_hash(hash, key, value)
        @redis.hset(hash,key,value)
    end
    
    def get_hash_value(hash, key)
        @redis.hget(hash,key)
    end
    
    def increment(key)
        @redis.incr(key)
    end

end