





--TODO
--Instantiate the wrapper.
--Write the clock and reset processes.
--Install a simulator (GHDL first).
--Put the real program in the .mif.




-- part 3
process
begin
  wait until T_Info = "001" and outPC = x"00000003";   -- program finished
  wait for 1 ns;             -- let outputs settle
  assert ... (your A check)
  assert ... (your B check)
  wait;                      -- stop this process forever
end process;