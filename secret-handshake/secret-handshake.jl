const secrets = ["wink", "double blink", "close your eyes", "jump"]

function secret_handshake(code::Integer)::Vector
  s = secrets[findall(d -> d == '1', string(code, base=2)[end:-1:max(1,end-3)])]
  return 16 & code == 16 ? reverse(s) : s
end
