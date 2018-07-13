module tym.data;
import std.datetime;
import std.regex;
import std.conv;
import tym.implementation;
import vibe.d;

enum DbType {
  dbBool,
  dbBytes,
  dbChar,
  dbDateTime,
  dbDecimal,
  dbDouble,
  dbFloat,
  dbInt16,
  dbInt32,
  dbInt64,
  dbMoney
}

public enum DbFlavour {
  postgres = 1,
  mysql = 2, // Not yet supported
  mssqlserver = 3 // Not yet supported
}

public interface ITable {
  string Schema();
  string Name();
  IColumn[] Columns();
}

public interface IColumn {
  string Name();
  void Name(string name);
  IType Type();
  void Type(IType type);
  void setValue(bool value);
  void setValue(byte[] value);
  void setValue(ubyte[] value);
  void setValue(short value);
  void setValue(ushort value);
  void setValue(int value);
  void setValue(uint value);
  void setValue(long value);
  void setValue(ulong value);
  void setValue(float value);
  void setValue(double value);
  void setValue(real value);
  void setValue(string value);
  void setValue(DateTime value);
  string getValue();
}

interface IType {
  string name(DbFlavour dbType);
  DbType type();
}

class NotYetImplementedException : Exception {
  this(string msg, string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}
class DbTypeException : Exception {
  this(string msg, string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}

public bool FlavourCheck(){
  Settings s;
  switch(s.dbFlavour) {
    case DbFlavour.mysql:
      throw new NotYetImplementedException("MySQL is not supported yet. Please use postgresql");
    case DbFlavour.mssqlserver:
      throw new NotYetImplementedException("Microsoft SQL Server is not supported yet. Please use postgresql");
    case DbFlavour.postgres:
    default:
      return true;
  }
}

class DbBool : IType {
  DbType type() { return DbType.dbBool; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "bool";
    }
  }
}
class DbBytes : IType {
  DbType type() { return DbType.dbBytes; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "bytea";
    }
  }
}
class DbInt16 : IType {
  DbType type() { return DbType.dbInt16; }
  bool IsIdentity;

  this(bool isIdentity = false) {
    IsIdentity = isIdentity;
  }

  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "smallint";
    }
  }
}
class DbInt32 : IType {
  DbType type() { return DbType.dbInt32; }
  bool IsIdentity = false;

  this(bool isIdentity = false) {
    IsIdentity = isIdentity;
  }

  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "integer";
    }
  }
}
class DbInt64 : IType {
  DbType type() { return DbType.dbInt64; }
  bool IsIdentity = false;

  this(bool isIdentity = false) {
    IsIdentity = isIdentity;
  }

  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "bigint";
    }
  }
}
class DbFloat : IType {
  DbType type() { return DbType.dbFloat; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "real";
    }
  }
}
class DbDouble : IType {
  DbType type() { return DbType.dbDouble; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "double precision";
    }
  }
}
class DbDecimal : IType {
  DbType type() { return DbType.dbDecimal; }
  short length = 24; // Override this as applicable
  short precision = 12; // Override this as applicable
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "numeric(" ~ to!string(length) ~ ',' ~ to!string(precision) ~ ')';
    }
  }
}
class DbMoney : IType {
  DbType type() { return DbType.dbMoney; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "money";
    }
  }
}
class DbChar : IType {
  private int _length = -1;
  DbType type() { return DbType.dbChar; }

  this(int length = -1) {
     _length = length;
  }

  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return (_length == -1 ? "text" : "varchar(" ~ to!string(_length) ~ ")");
    }
  }
}
class DbDateTime : IType {
  DbType type() { return DbType.dbDateTime; }
  string name(DbFlavour dbType) {
    switch(dbType) {
      case DbFlavour.mysql:
      case DbFlavour.mssqlserver:
        // NotYetImplementedException
        FlavourCheck();
        return "";
      case DbFlavour.postgres:
      default:
        return "timestamp";
    }
  }
}
class Column : IColumn {
  private string _value;
  private string _name;
  private IType _type;

  string Name() { return _name; }
  void Name(string name) { _name = name; }
  IType Type() { return _type; }
  void Type(IType type) { _type = type; }

  public this() { }

  public this(string name, IType type){
    _name = name;
    _type = type;
  }

  void setValue(bool value) {
    if(Type.type != DbType.dbBool)  {
      throw new DbTypeException("Cannot cast type to bool");
    }
    _value = to!string((value ? 1 : 0));
  }
  void setValue(byte[] value) {
    if(Type.type != DbType.dbBytes) {
      throw new DbTypeException("Cannot cast type to byte array");
    }
    _value = to!string(value);
  }
  void setValue(ubyte[] value) {
    if(Type.type != DbType.dbBytes) {
      throw new DbTypeException("Cannot cast type to byte array");
    }
    _value = to!string(value);
  }
  void setValue(short value) {
    if(Type.type != DbType.dbInt16) {
      throw new DbTypeException("Cannot cast type to int16");
    }
    _value = to!string(value);
  }
  void setValue(ushort value) {
    if(Type.type != DbType.dbInt16) {
      throw new DbTypeException("Cannot cast type to int16");
    }
    _value = to!string(value);
  }
  void setValue(int value) {
    if(Type.type != DbType.dbInt32) {
      throw new DbTypeException("Cannot cast type to int32");
    }
    _value = to!string(value);
  }
  void setValue(uint value) {
    if(Type.type != DbType.dbInt32) {
      throw new DbTypeException("Cannot cast type to int32");
    }
    _value = to!string(value);
  }
  void setValue(long value) {
    if(Type.type != DbType.dbInt64) {
      throw new DbTypeException("Cannot cast type to int64");
    }
    _value = to!string(value);
  }
  void setValue(ulong value) {
    if(Type.type != DbType.dbInt64) {
      throw new DbTypeException("Cannot cast type to int64");
    }
    _value = to!string(value);
  }
  void setValue(float value) {
    if(Type.type != DbType.dbFloat) {
      throw new DbTypeException("Cannot cast type to float");
    }
    _value = to!string(value);
  }
  void setValue(double value) {
    if(Type.type != DbType.dbDouble) {
      throw new DbTypeException("Cannot cast type to double");
    }
    _value = to!string(value);
  }
  void setValue(real value) {
    if(Type.type != DbType.dbDecimal) {
      throw new DbTypeException("Cannot cast type to real");
    }
    _value = to!string(value);
  }
  void setValue(string value) {
    if(Type.type != DbType.dbChar) {
      throw new DbTypeException("Cannot cast type to string");
    }
    _value = "'" ~ value ~ "'";
  }
  void setValue(DateTime value) {
    if(Type.type != DbType.dbDateTime) {
      throw new DbTypeException("Cannot cast type to datetime");
    }
    _value = "'" ~ to!string(value) ~ "'";
  }
  public string getValue() {
    return _value;
  }
}
