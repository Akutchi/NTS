with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets;          use GNAT.Sockets;

with Ada.Streams;
use type Ada.Streams.Stream_Element_Count;

package Nts_App is

    type nts_agregator is private;
    type Any_nts is access all nts_agregator;

    function nts return Any_nts;

    procedure Listen (N : Any_nts; Port_Nb : Port_Type);


private

    function Check_End (Data : Unbounded_String;
                        First_CR_Passed : in out Boolean;
                        Offset_Before_EndCheck : in out Natural)
    return Boolean;

    type nts_agregator is record

        Server : Socket_Type;
        Socket : Socket_Type;
        Address: Sock_Addr_Type;
        Channel: Stream_Access;

        Offset  : Ada.Streams.Stream_Element_Count;
        Receive : Ada.Streams.Stream_Element_Array (1 .. 1);
        Data    : Unbounded_String := To_Unbounded_String ("");

    end record;

end Nts_App;