with Ada.Text_IO;   use Ada.Text_IO;
with GNAT.Sockets;  use GNAT.Sockets;

with Ada.Streams;
use type Ada.Streams.Stream_Element_Count;

package body Nts_App is

    function nts return Any_nts
    is
        One_Nts : Any_nts := new nts_agregator;
    begin
        GNAT.Sockets.Initialize;
        Create_Socket (One_Nts.Server);
        Set_Socket_Option (One_Nts.Server,
                           Socket_Level,
                           (Reuse_Address, True));
        Set_Socket_Option (One_Nts.Server,
                           Socket_Level,
                           (Receive_Timeout, Timeout => 5.0));

        return One_Nts;
    end nts;

    procedure Listen (N : Any_nts; Port_Nb : Port_Type)
    is
    begin

        Bind_Socket (N.Server,  Address =>
                                (Family => Family_Inet,
                                Addr => Inet_Addr ("127.0.0.1"),
                                Port => Port_Nb));
        Listen_Socket (N.Server);
        Accept_Socket(N.Server, N.Socket, N.Address);
        N.Channel := Stream (N.Socket);

        loop
            Ada.Streams.Read (N.Channel.All, N.Data, N.Offset);
            Put (Character'Val (N.Data (N.Data'First)));
        end loop;

    end Listen;

end Nts_App;