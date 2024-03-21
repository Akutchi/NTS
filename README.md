# NTS
NTS (NoTypeScript) is a backend for Ada

# Structure

The way I will structure it is the same as [express](https://expressjs.com/en/starter/hello-world.html).

## Example
```ada
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
```
