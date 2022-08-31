--What grades are stored in the database?
SELECT *
FROM Grade
--What emotions may be associated with a poem?
SELECT *
FROM Emotion
--How many poems are in the database?
SELECT COUNT(P.Id)
FROM Poem P
--Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 A.Name, A.Id
FROM Author A
ORDER BY A.Name

--Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 A.Name, A.Id, G.Name
FROM Author A
JOIN Grade G ON G.Id = A.GradeId
ORDER BY A.Name
--Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 A.Name, A.Id, G.Name 'Gender'
FROM Author A
JOIN Gender G ON G.Id = A.GenderId
ORDER BY A.Name
--What is the total number of words in all poems in the database?
SELECT SUM(P.WordCount)
FROM POEM P
--Which poem has the fewest characters?
SELECT TOP 1 P.*
FROM Poem P
ORDER BY P.CharCount ASC
--How many authors are in the third grade?
SELECT COUNT(A.Id)
FROM Author A
JOIN Grade G ON G.Id = A.GradeId
WHERE G.Name = '3rd Grade'

--How many total authors are in the first through third grades?
SELECT COUNT(A.Id)
FROM Author A
WHERE A.GradeId IN (1,2,3)

--What is the total number of poems written by fourth graders?
SELECT COUNT(P.Id)
FROM Poem P 
JOIN Author A ON P.AuthorId = A.Id
JOIN Grade G ON A.GradeId = G.Id
WHERE G.Id = 4

--How many poems are there per grade?
SELECT G.Name, COUNT(P.Id)
FROM Poem P 
JOIN Author A ON P.AuthorId = A.Id
JOIN Grade G ON A.GradeId = G.Id
GROUP BY G.Name

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT G.Name, COUNT(A.Id) 
FROM Author A
JOIN Grade G ON A.GradeId = G.Id
GROUP BY G.Name

--What is the title of the poem that has the most words?
SELECT TOP 1 P.*
FROM Poem P
ORDER BY P.WordCount DESC

--Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 10 A.Id, A.Name, COUNT(P.AuthorId) 'Number of Poems'
FROM Author A
LEFT JOIN POEM P ON A.Id = P.AuthorId
GROUP BY A.Id, A.Name
ORDER BY COUNT(P.AuthorId) DESC

--How many poems have an emotion of sadness?
SELECT COUNT(P.Id)
FROM Poem P
JOIN PoemEmotion PE ON P.Id = PE.PoemId
JOIN Emotion E ON E.Id = PE.EmotionId
WHERE E.Name = 'Sadness'

--How many poems are not associated with any emotion?
SELECT COUNT(P.Id)
FROM Poem P
LEFT JOIN PoemEmotion PE ON P.Id = PE.PoemId
WHERE PE.Id IS NULL

--Which emotion is associated with the least number of poems?
SELECT COUNT (P.Id), E.Name
FROM Emotion E
JOIN PoemEmotion PE ON PE.EmotionId = E.Id
JOIN Poem P ON P.Id = PE.PoemId
GROUP BY E.Name

--Which grade has the largest number of poems with an emotion of joy?
SELECT G.Name, COUNT(P.Id)
FROM Poem P 
JOIN PoemEmotion PE ON PE.PoemId = P.Id
JOIN Emotion E ON PE.EmotionId = E.Id
JOIN AUTHOR A ON A.Id = P.AuthorId
JOIN GRADE G ON G.Id = A.GradeId
WHERE E.Name = 'Joy'
GROUP BY G.Name

--Which gender has the least number of poems with an emotion of fear?
SELECT G.Name, COUNT(P.Id)
FROM Poem P 
JOIN PoemEmotion PE ON PE.PoemId = P.Id
JOIN Emotion E ON PE.EmotionId = E.Id
JOIN AUTHOR A ON A.Id = P.AuthorId
JOIN GENDER G ON G.Id = A.GenderId
WHERE E.Name = 'Fear'
GROUP BY G.Name
