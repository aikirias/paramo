CREATE TABLE [dbo].[Pizza](
[id] [int] NOT NULL,
[name] [varchar](50) NULL,
[ingredients] [varchar](50) NULL,
CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED
(
[id] ASC
)
) ON [PRIMARY]
CREATE TABLE [dbo].[Ingredients](
[id] [int] NOT NULL,
[name] [varchar](40) NULL,
CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED
(
[id] ASC
)
) ON [PRIMARY]
CREATE TABLE [dbo].[Orders](
[order_id] [int] NOT NULL,
[customer_id] [int] NULL,
[pizza_id] [int] NULL,
[exclusions] [varchar](4) NULL,
[extras] [varchar](4) NULL,
[order_time] [datetime] NULL
) ON [PRIMARY]

INSERT [dbo].[Ingredients] ([id], [name]) VALUES (1, N'Bacon')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (2, N'BBQ Sauce')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (3, N'Beef')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (4, N'Cheese')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (5, N'Chicken')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (6, N'Mushrooms')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (7, N'Onions')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (8, N'Pepperoni')

INSERT [dbo].[Ingredients] ([id], [name]) VALUES (9, N'Peppers')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (10, N'Salami')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (11, N'Tomatoes')
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (12, N'Tomato Sauce') 
INSERT [dbo].[Ingredients] ([id], [name]) VALUES (13, N'Prosciutto')

INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(1, 101, 1, N'', N'', CAST(N'2021-02-01T18:05:02.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(2, 101, 1, N'', N'', CAST(N'2021-02-01T19:00:52.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(3, 102, 1, N'', N'', CAST(N'2021-03-02T23:51:23.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(3, 102, 2, N'', NULL, CAST(N'2021-03-02T23:51:23.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(4, 103, 1, N'4', N'', CAST(N'2021-05-04T13:23:46.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(4, 103, 2, N'4', N'', CAST(N'2021-05-04T13:23:46.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(5, 104, 1, N'null', N'1', CAST(N'2021-06-08T21:00:29.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(6, 101, 2, N'null', N'null', CAST(N'2021-06-08T21:03:13.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(7, 105, 2, N'null', N'1', CAST(N'2021-06-08T21:20:29.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(8, 102, 1, N'null', N'null', CAST(N'2021-07-09T23:54:33.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(9, 103, 1, N'4', N'1, 5', CAST(N'2021-08-10T11:22:59.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(10, 104, 1, N'null', N'null', CAST(N'2021-09-11T18:34:49.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(10, 104, 1, N'2, 6', N'1, 4', CAST(N'2021-09-11T18:34:49.000' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [customer_id], [pizza_id], [exclusions], [extras], [order_time]) VALUES
(11, 115, 3, NULL, N'8', CAST(N'2021-09-11T19:45:29.000' AS DateTime))

INSERT [dbo].[Pizza] ([id], [name], [ingredients]) VALUES (1, N'Carnivore', N'1, 2, 3, 4, 5, 6, 8, 10')
INSERT [dbo].[Pizza] ([id], [name], [ingredients]) VALUES (2, N'Vegetarian', N'4, 6, 7, 9, 11, 12')
INSERT [dbo].[Pizza] ([id], [name], [ingredients]) VALUES (3, N'Prosciutto e sql', N'11, 12, 13, 6')
