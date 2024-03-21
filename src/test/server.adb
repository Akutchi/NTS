with GNAT.Sockets;  use GNAT.Sockets;
with Ada.Text_IO;   use Ada.Text_IO;

with Nts_App; use Nts_App;

procedure Server
is

    App  : Any_nts := nts;
    Port : Port_Type := 3080;

begin

    Listen (App, Port);

end Server;