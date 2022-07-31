-- lenh xoa DB
DROP DATABASE IF EXISTS Test;
-- lenh tao DB
CREATE DATABASE Test;
-- lenh su dung DB
USE Test;
-- Tao bang du lieu
-- tao bang Department, Position, account
CREATE TABLE Department (
		DepartmentID 	 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		DepartmentName	 VARCHAR (30) NOT NULL
);
CREATE TABLE `Position` (
		PositionID 		 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		PositionName	 ENUM('DEV','TEST','SCRUM MASTER','PM') NOT NULL
);
CREATE TABLE `Account` (
		AccountID 		 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Email        	 VARCHAR(30) NOT NULL UNIQUE KEY,
        Username	     VARCHAR(30) NOT NULL UNIQUE KEY,
        Fullname 	   	VARCHAR(30) NOT NULL,
        
        DepartmentID    TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
        PositionID		TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID),
        CreateDate       DATETIME DEFAULT NOW()
);	 




-- Thêm dữ liệu
-- Thêm dữ liệu cho bảng Department
INSERT INTO Department(departmentID,departmentName)
VALUES (1,'Bao ve');
INSERT INTO Department(departmentName)
VALUES                ('Marketing'),
                      ('Sale');
-- Thêm dữ liệu cho Position ( chú ý : do chỉ có 4 dữ liệu như trên nhập )
INSERT INTO `Position`(PositionName)
VALUE                  ('Dev'),
                       ('Test'),
                       ('Scrum Master'),
                       ('PM');
SELECT*FROM `Account`;
-- tao bang 4 Group ( can hoi tai sao CreatorID khong can Primarykey)
CREATE TABLE `Group` (
		GroupID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        GroupName      VARCHAR(50) NOT NULL,
        CreatorID      TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (CreatorID) REFERENCES`Account`(AccountID),
        CreateDate	   DATETIME DEFAULT NOW()
);
-- tao bang 5 GroupAccount
CREATE TABLE GroupAccount(
		GroupID		   TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (GroupID) REFERENCES`Group`(GroupID),
		AccountID	   TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (AccountID) REFERENCES`Account`(AccountID),
		JoinDate       DATETIME DEFAULT NOW(),
		PRIMARY KEY (GroupID,AccountID)
);
-- Tạo bảng 6 TypeQuestion( Cần hỏi kiểu TypeName có trùng lặp đc ko (UNIQUE KEY)
CREATE TABLE TypeQuestion(
		TypeID         TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        TypeName       ENUM('Essay', 'Multiple-Choice') NOT NULL
);
-- Tạo bảng 7 CategoryQuestion : Cần hỏi kiểu CategoryName có trùng lặp đc ko (UNIQUE KEY)
CREATE TABLE CategoryQuestion(
		CategoryID     TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		CategoryName   VARCHAR(50) NOT NULL
);
-- Tạo bảng 8 Question : Chú ý phần CreatorID( giống admin-> liên kết với AccountID
CREATE TABLE Question(
		QuestionID      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content	  		VARCHAR(200) NOT NULL,
        CategoryID	  	TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
		TypeID  		TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
		CreatorID  		TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
        CreateDate  	DATETIME DEFAULT NOW()
);
-- Tạo bảng 9 Answer
CREATE TABLE Answer(
		AnswerID	 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Content         VARCHAR(50) NOT NULL,
        QuestionID	 	TINYINT UNSIGNED NOT NULL,
		isCorrect	  	ENUM('ĐÚNG','SAI') NOT NULL,
		FOREIGN KEY(QuestionID)  REFERENCES Question(QuestionID)
);
-- tạo bảng 10 exam
CREATE TABLE Exam(
		ExamID  		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `Code`		 	VARCHAR(10) NOT NULL,
        Title 		  	VARCHAR(50) NOT NULL,
        CategoryID  	TINYINT UNSIGNED NOT NULL,
        Duration  		TINYINT UNSIGNED NOT NULL,
        CreatorID  		TINYINT UNSIGNED NOT NULL,
        CreateDate  	DATETIME DEFAULT NOW(),
        FOREIGN KEY(CategoryID)  REFERENCES CategoryQuestion(CategoryID),
        FOREIGN KEY(CreatorID)  REFERENCES `Account`(AccountID)
);
-- tạo bảng ExamQuestion
CREATE TABLE ExamQuestion(
		ExamID  	  	TINYINT UNSIGNED NOT NULL,
        QuestionID 	 	TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY(ExamID)  REFERENCES Exam(ExamID),
        FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);
-- ------------------------------------------ THÊM DỮ LIỆU VÀO BẢNG--------------------------------
-- INSERT DATA DEPARTMENT
INSERT INTO   Department(departmentName)
VALUE 	    	    	('Marketing'	 ),
						('Sale'		     ),
						('Bảo vệ'		 ),
						('Nhân sự'	     ),
						('Kỹ thuật'	     ),
						('Tài chính'	 ),
						('Phó giám đốc'  ),
						('Giám đốc'	     ),
						('Thư kí'		 ),
						('Bán hàng'	     );
-- INSERT DATA Position
INSERT INTO `Position`(PositionName)
VALUE                 ('Dev'			),
					  ('Test'			),
				      ('Scrum Master'	),
					  ('PM'		     	);
-- INSERT DATA Account
INSERT INTO `Account` (Email                            ,  Username          ,Fullname                   ,DepartmentID      ,PositionID       ,CreateDate     )
VALUE                 ('Email1@gmail.com'				, 'Username1'		,'Fullname1'				,   1		    ,   2		 ,'2020-03-05'),
					  ('Email2@gmail.com'				, 'Username2'		,'Fullname2'				,   2		    ,   2		 ,'2020-03-05'),
                      ('Email3@gmail.com'				, 'Username3'		,'Fullname3'				,   3			,   2		 ,'2020-03-07'),
                      ('Email4@gmail.com'				, 'Username4'		,'Fullname4'				,   4			,   4		 ,'2020-03-08'),
                      ('Email5@gmail.com'				, 'Username5'		,'Fullname5'				,   5			,   2		 ,'2020-03-10'),
                      ('Email6@gmail.com'				, 'Username6'		,'Fullname6'				,   6			,   3		 ,'2020-04-05'),
                      ('Email7@gmail.com'				, 'Username7'		,'Fullname7'				,   7			,   2		 ,'2020-04-05'),
                      ('Email8@gmail.com'				, 'Username8'		,'Fullname8'				,   8       	,   1		 ,'2020-04-07'),
                      ('Email9@gmail.com'				, 'Username9'		,'Fullname9'				,   9			,   2		 ,'2020-04-07'),
                      ('Email10@gmail.com'			    , 'Username10'		,'Fullname10'				,   10     		,   1        ,'2020-04-09');            
-- INSERT DATA Group
INSERT INTO `Group`(GroupName               ,CreatorID      ,CreateDate  )
VALUE              ('VTI Sale 01'	    	,   1			,'2019-03-05'),
				   ('VTI Sale 02'			,   2			,'2020-03-07'),
				   ('VTI Sale 03'			,   3			,'2020-03-09'),
				   ('VTI Sale 04'			,   4			,'2020-03-10'),
				   ('VTI Sale 05'			,   5			,'2020-03-28'),
				   ('VTI Sale 06'			,   6			,'2020-04-06'),
				   ('VTI Sale 07'	        ,   7			,'2020-04-07'),
				   ('VTI Sale 08'			,   8			,'2020-04-08'),
				   ('VTI Sale 09'		    ,   9			,'2020-04-09'),
				   ('VTI Sale 10'		    ,   10			,'2020-04-10');
-- INSERT DATA GroupAccount
INSERT INTO GroupAccount(GroupID           ,AccountID                ,JoinDate              )
VALUE                   (	1		,    1		                     ,'2019-03-05'),
					    (	2		,    2		                     ,'2020-03-07'),
					    (	3		,    3		                     ,'2020-03-09'),
						(	4		,    4		                     ,'2020-03-10'),
						(	5		,    5		                     ,'2020-03-28'),
						(	6		,    6		                     ,'2020-04-06'),
						(	7		,    7		                     ,'2020-04-07'),
						(	8		,    8		                     ,'2020-04-08'),
						(	9		,    9		                     ,'2020-04-09'),
						(	10		,    10		                     ,'2020-04-10');
-- INSERT DATA TypeQuestion
INSERT INTO TypeQuestion( TypeName           )
VALUE                   ('Essay'            ),
						('Multiple-Choice'   );
-- INSERT DATA CategoryQuestion
INSERT INTO    CategoryQuestion       (CategoryName)
VALUE                                 ('Java'			),
							          ('ASP.NET'		),
							          ('ADO.NET'		),
							          ('SQL'			),
								      ('Postman'		),
									  ('Ruby'			),
							          ('Python'		    ),
							          ('C++'		   	),
							          ('C #'		    ),
									  ('PHP'			);
-- INSERT DATA Question
INSERT INTO   Question(Content			    , CategoryID, TypeID		, CreatorID	, CreateDate )
VALUE                 ('Câu hỏi về Java'	,	1		,   1			,   1		,'2020-04-05'),
					  ('Câu Hỏi về PHP'	    ,	10		,   2			,   2		,'2020-04-05'),
					  ('Hỏi về C#'		    ,	9		,   2			,   3		,'2020-04-06'),
					  ('Hỏi về Ruby'	    ,	6		,   1			,   4		,'2020-04-06'),
					  ('Hỏi về Postman'	    ,	5		,   1			,   5		,'2020-04-06'),
					  ('Hỏi về ADO.NET'	    ,	3		,   2			,   6		,'2020-04-06'),
					  ('Hỏi về ASP.NET'	    ,	2		,   1			,   7		,'2020-04-06'),
					  ('Hỏi về C++'		    ,	8		,   1			,   8		,'2020-04-07'),
					  ('Hỏi về SQL'		    ,	4		,   2			,   9		,'2020-04-07'),
					  ('Hỏi về Python'	    ,	7		,   1			,   10   	,'2020-04-07');
-- INSERT DATA Answer
INSERT INTO     Answer(  Content		, QuestionID	, isCorrect	)
VALUES 				  ('Trả lời 01'	    ,   1			,	'Đúng'	),
					  ('Trả lời 02'	    ,   4			,	'Sai'	),
                      ('Trả lời 03'    	,   1			,	'Đúng'	),
                      ('Trả lời 04'	    ,   1			,	'Đúng'	),
                      ('Trả lời 05'	    ,   6			,	'Sai'	),
                      ('Trả lời 06'	    ,   3			,	'Sai'	),
                      ('Trả lời 07'	    ,   7			,	'Sai'	),
                      ('Trả lời 08'	    ,   7			,	'Đúng'	),
                      ('Trả lời 09'	    ,   9			,	'Sai'	),
                      ('Trả lời 10'	    ,   10			,	'Đúng'	);
-- INSERT DATA Exam
INSERT INTO    Exam(`Code`			, Title				, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('MT01'		,'Đề thi C#'			,	9			,	60		,   5			,'2019-04-05'),
					('MT02'		,'Đề thi PHP'			,	10			,	60		,   2			,'2019-04-05'),
                    ('MT03'		,'Đề thi C++'			,	8			,	120		,   2			,'2019-04-07'),
                    ('MT04'		,'Đề thi Java'		    ,	1			,	60		,   3			,'2020-04-08'),
                    ('MT05'		,'Đề thi Ruby'		    ,	6		    ,	120		,   4			,'2020-04-10'),
                    ('MT06'		,'Đề thi Postman'		,	5			,	60		,   6			,'2020-04-05'),
                    ('MT07'		,'Đề thi SQL'			,	4			,	60		,   7			,'2020-04-05'),
                    ('MT08'		,'Đề thi Python'		,	7			,	60		,   8			,'2020-04-07'),
                    ('MT09'		,'Đề thi ADO.NET'		,	3			,	90		,   9			,'2020-04-07'),
                    ('MT10'		,'Đề thi ASP.NET'		,	2			,	90		,   10	    	,'2020-04-08');          
-- INSERT DATA ExamQuestion
INSERT INTO    ExamQuestion(ExamID	, QuestionID	) 
VALUES 					   (	1	,		5		),
						   (	2	,		10		), 
						   (	3	,		4		), 
						   (	4	,		3		), 
						   (	5	,		7		), 
						   (	6	,		10		), 
						   (	7	,		2		), 
						   (	8	,		10		), 
						   (	9	,		9		), 
						   (	10	,		8		); 
-- làm bài tập
-- TS4
-- QS1 : Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `Account` a
INNER JOIN department d ON d.DepartmentID = a.DepartmentID;
-- QS2 : Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2020
SELECT * FROM `Account`
WHERE CreateDate < '2020-12-20';
-- QS3 : Viết lệnh để lấy ra tất cả các developer
SELECT * FROM `Account` a
INNER JOIN position p ON p.PositionID = a.PositionID
WHERE p.PositionName = 'Dev';
-- QS 4 : Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT * FROM `department`;
SELECT d.DepartmentName,a.DepartmentID,count(*) as SL FROM `Account` a
INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
GROUP BY a.departmentID
HAVING count(*) >= 3 ;
-- QS 5 : Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT * FROM `exam`;
SELECT * FROM `examquestion`;
SELECT * FROM `question`;
WITH CTE_Countqs AS ( 
SELECT Count(1) AS SL FROM `examquestion` eq
GROUP BY QuestionID )
SELECT eq.QuestionID,Count(1) FROM `examquestion` eq
INNER JOIN question q ON q.QuestionID = eq. QuestionID
GROUP BY QuestionID
HAVING Count(1) = (SELECT max(SL) FROM CTE_Countqs );
-- QS 6 : Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT * FROM CategoryQuestion;
SELECT * FROM `question`;
SELECT cq.CategoryID, cq.CategoryName,count(CQ.CategoryID) FROM CategoryQuestion CQ 
INNER JOIN `question` q ON CQ.CategoryID = q.CategoryID
GROUP BY CategoryID ;
-- QS 7 : Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT * FROM `question`;
SELECT * FROM Examquestion;
SELECT EQ.ExamID,EQ.QuestionID,COUNT(1) AS SL FROM Examquestion EQ
RIGHT JOIN `question` Q ON q.QuestionID = EQ.QuestionID
GROUP BY QuestionID;
-- QS 8 :Lấy ra Question có nhiều câu trả lời nhất
SELECT * FROM `question`;
SELECT * FROM  Answer;
WITH CTE_max AS (
SELECT Count(1) AS SL FROM Answer a
GROUP BY QuestionID)
SELECT Q.QuestionID, Q.Content, Count(1) AS SL FROM Answer a
INNER JOIN `question` q ON q.QuestionID = a.QuestionID
GROUP BY QuestionID
HAVING Count(1) = (SELECT max(SL) FROM CTE_max );
-- QS 9 : Thống kê số lượng account trong mỗi group
SELECT * FROM `groupaccount`;
SELECT * FROM `group`;
SELECT g.GroupID,g.GroupName,COUNT(1) AS SL FROM `groupaccount` GC
INNER JOIN `Group` G ON g.GroupID = GC.GroupID
GROUP BY GroupID;
-- QS10 : Tìm chức vụ có ít người nhất
SELECT * FROM `account`;
SELECT * FROM `Position`;
SELECT COUNT(1) FROM `account` ac;
WITH CTE_min AS (
SELECT  COUNT(1) AS SL FROM `account` ac
GROUP BY ac.PositionID)
SELECT p.PositionName,ac.positionID,COUNT(1) AS SL FROM `account` ac
INNER JOIN `Position` P ON P.PositionID = ac.PositionID
GROUP BY ac.PositionID
HAVING COUNT(1) = (SELECT min(SL) FROM CTE_min);
-- QS11 : Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT * FROM `account`;
SELECT * FROM department;
SELECT * FROM `position`;
SELECT d.departmentName,COUNT(1) FROM `account` a
INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
INNER JOIN `Position` p ON p.PositionID = a.PositionID
GROUP BY d.DepartmentID,p.PositionID;
-- QS12 : Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT * FROM `answer`; -- câu trả lời
SELECT * FROM `categoryquestion`;-- Loại câu hỏi
SELECT * FROM `typequestion`;-- loại câu hỏi
SELECT * FROM `account`; -- Người tạo ra câu hỏi
SELECT * FROM `question`;
SELECT q.QuestionID,q.Content,a.FullName,Tq.TypeName,ANS.Content FROM `question` q
INNER JOIN Typequestion tq ON q.TypeID = tq.TypeID
INNER JOIN Categoryquestion cq ON cq.CategoryID = Q.CategoryID
INNER JOIN `account` a ON a.AccountID = q.CreatorID
INNER JOIN Answer ANS ON ANS.QuestionID = q.QuestionID;
-- QS 13 : Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT * FROM `question`;
SELECT * FROM `typequestion`;
SELECT q.TypeID,tq.TypeName,COUNT(1) FROM `question` q
INNER JOIN `typequestion` tq ON tq.TypeID = q.TypeID
GROUP BY TypeID;
-- QS 14:Lấy ra group không có account nào
SELECT * FROM `groupaccount`;
SELECT * FROM `group`;
SELECT * FROM `group` g
LEFT JOIN `groupaccount` ga ON g.GroupID = ga.GroupID
WHERE AccountID IS NULL;
-- QS 16 : Lấy ra question không có answer nào
SELECT * FROM `question`;
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID 
WHERE a.AnswerID IS NULL;
-- QS 17 : a) Lấy các account thuộc nhóm thứ 1
	    -- b) Lấy các account thuộc nhóm thứ 2
		-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT * FROM `account`;
SELECT * FROM `groupaccount`;
-- Lấy các account thuộc nhóm thứ 1
SELECT a.Email,a.FullName FROM `Account` a
INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1 ;
-- Lấy các account thuộc nhóm thứ 2
SELECT a.Email,a.FullName FROM `Account` a
INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2 ;
-- Ghép 2 kq lại với nhau
SELECT a.Email,a.FullName FROM `Account` a
INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1
UNION
SELECT a.Email,a.FullName FROM `Account` a
INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;
-- QS 18 : a) Lấy các group có lớn hơn 5 thành viên
        -- b) Lấy các group có nhỏ hơn 7 thành viên
        -- c) Ghép 2 kết quả từ câu a) và câu b)
-- Lấy các group có lớn hơn 5 thành viên
SELECT * FROM `group`;
SELECT * FROM `groupaccount`;
SELECT ga.GroupID,ga.AccountID,g.GroupName ,COUNT(1) AS SL FROM `groupaccount` ga
INNER JOIN `group` g ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) > 5;
-- Lấy các group có nhỏ hơn 7 thành viên
SELECT ga.GroupID,ga.AccountID,g.GroupName ,COUNT(1) AS SL FROM `groupaccount` ga
INNER JOIN `group` g ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) < 7;
-- Ghép 2 kết quả từ câu a) và câu b)
SELECT ga.GroupID,ga.AccountID,g.GroupName ,COUNT(1) AS SL FROM `groupaccount` ga
INNER JOIN `group` g ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) > 5
UNION
SELECT ga.GroupID,ga.AccountID,g.GroupName ,COUNT(1) AS SL FROM `groupaccount` ga
INNER JOIN `group` g ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) < 7;

