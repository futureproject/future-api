module AsyncHelper

  def cue_async
    [-1, {}, []]
  end

  #def asynchronously(args={})
    #headers =  {
      #'Content-Type' => (args[:content_type] || 'application/json')
    #}
    #status = args[:status] || 200
    #EM.next_tick do
      #response = yield
      #env['async.callback'].call [status, headers, response]
    #end
    #cue_async
  #end

  def asynchronously(args={})
    Thin::AsyncResponse.perform(env) do |response|
      content_type(args[:content_type] || 'application/json')
      response.status = args[:status] || 200
      EM.defer do
        res = yield
        response << res
        response.done
      end
    end
  end
end
