Facter.add('tcrole') do
  setcode "test -f /etc/tcrole && cat /etc/tcrole || echo 'none'"
end