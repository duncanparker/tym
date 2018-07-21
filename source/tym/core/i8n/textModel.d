module tym.core.i8n.textModel;

/**
* Default dictionary of translatable terms.
* remarks:	You may derive more languages by inheriting from this struct.
*/
struct Text {
	string title = "Tym";
	string catchphrase = "Tym is of the essence.";
	string username;
	string password;
	string copyright = "© Duncan Parker 2018";
	string login;
}
