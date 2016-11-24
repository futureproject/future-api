module AsyncHelper

  def complete_async_with(body, headers={'Content-Type' => 'text/plain'}, status=200)
    puts env
    env['async.callback'].call [status, headers, body]
  end

  def signal_async
    [-1, {}, []]
  end

end
