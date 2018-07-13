module tym.motd;
import tym.data;

class MOTD : ITable {
	string Schema() { return "dbo"; }
	string Name() { return "motd"; }
	Column ID = new Column("ID", new DbInt16(true));
	Column text = new Column("ID", new DbChar(100));
	IColumn[] Columns() { return [ ID, text ]; }
}
