module AsyncHelper

  def cue_async
    [-1, {}, []]
  end

  def asynchronously(args={})
    headers =  {
      'Content-Type' => (args[:content_type] || 'application/json')
    }
    status = args[:status] || 200
    EM.defer do
      response = yield
      env['async.callback'].call [status, headers, response]
      env['async.close'].callback
    end
    cue_async
  end

end
