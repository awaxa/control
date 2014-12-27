#!/bin/sh

puppet apply --execute 'include role::workstation' --modulepath='/tmp/control/site:/tmp/control/modules'
r10k deploy environment -pv
facter is_virtual | grep -q true && puppet resource user vagrant password='$6$w26kYwUf$lwsr9fpifv.rrnY4xBOtbcZAuhjlbhHktEI7rhWaCdm0UZkdm/MXRMQpgMmTdQUp64ccgHgANspgwJrYsuYjz.'
start lightdm
