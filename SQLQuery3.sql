USE [DB4]
GO

CREATE TABLE profucts(
	[id] [int] Primary Key Identity(1,1)NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[coast] [real] NOT NULL,
	[id_user] [int] NOT NULL,
	[create_data] [datetime] NOT NULL,
	CONSTRAINT FK_idusers FOREIGN KEY (id_user)
		REFERENCES users(id) ON DELETE CASCADE

) ON [PRIMARY]
GO
