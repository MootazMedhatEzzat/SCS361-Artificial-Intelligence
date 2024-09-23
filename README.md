# SCS361-Artificial-Intelligence


<div align="center">
  <table width="100%" border="1" cellpadding="10" cellspacing="0">
    <tr style="background-color:#f2f2f2;">
      <td align="center" colspan="2"><strong>Assignment 1: Prolog Friendship Rules</strong></td>
    </tr>
    <tr>
      <td align="center"><strong>Names:</strong><br>Ali Esmat Ahmed Orfy<br>Mootaz Medhat Ezzat Abdelwahab<br>Omar Adel Abdel Hamid Ahmed Brikaa</td>
      <td align="center"><strong>IDs:</strong><br>20206123<br>20206074<br>20206043</td>
    </tr>
    <tr style="background-color:#f9f9f9;">
      <td align="center"><strong>Program:</strong><br>Software Engineering</td>
      <td align="center"><strong>Group:</strong><br>B (S5)</td>
    </tr>
    <tr>
      <td align="center" colspan="2"><strong>Delivered To:</strong><br>Prof. Khaled Wassif</td>
    </tr>
  </table>
</div>

---

## 📝 Assignment #1 

Cairo University  
Faculty of Computers and Artificial Intelligence  
Artificial Intelligence Course (Spring 2023)

### 📄 Description

Given the attached knowledge base "data.pl" containing some "friend" relations, you are required to write a Prolog program that solves the tasks explained below.

### Task 1️⃣ [0.25 marks]:  
**Description**: Implement the `is_friend` rule, which ensures that the "friend" relation is symmetric (i.e., if X is friends with Y, then Y is friends with X).

**Examples**:  
```prolog
?- is_friend(ahmed, samy).
true.

?- is_friend(samy, ahmed).
true.
```
> **Note**: In the knowledge base, only the relation `friend(ahmed, samy)` is stored, but `is_friend` should return true for both directions.

### Task 2️⃣ [0.75 marks]:  
**Description**: Implement `friendList/2` to return a list of all friends for a given person.

**Examples**:  
```prolog
?- friendList(ahmed, L).
L = [samy, fouad].

?- friendList(huda, L).
L = [mariam, aisha, lamia].
```

### Task 3️⃣ [0.5 marks]:  
**Description**: Implement `friendListCount/2` to return the number of friends a person has. Use tail recursion to achieve this.

**Examples**:  
```prolog
?- friendListCount(ahmed, N).
N = 2.

?- friendListCount(huda, N).
N = 3.
```

### Task 4️⃣ [0.5 marks]:  
**Description**: Implement `peopleYouMayKnow/2` to suggest possible friends if a person shares at least one mutual friend with another person. Ensure that the suggested friend is not already a direct friend.

**Examples**:  
```prolog
?- peopleYouMayKnow(ahmed, X).
X = mohammed;
X = said;
...

?- peopleYouMayKnow(huda, X).
X = hagar;
X = zainab;
X = hend;
X = zainab;
...
```

### Task 5️⃣ [1 mark]:  
**Description**: Implement `peopleYouMayKnow/3` to suggest one possible friend who shares at least N mutual friends with the person. Ensure that the suggested friend is not already a direct friend.

**Examples**:  
```prolog
?- peopleYouMayKnow(ahmed, 2, X).
X = abdullah.
```
> **Explanation**: Ahmed is friends with Fouad and Samy, both of whom are also friends with Abdullah. Therefore, Abdullah is suggested to Ahmed as a potential friend.

```prolog
?- peopleYouMayKnow(huda, 3, X).
X = zainab.
```
> **Explanation**: Huda is friends with Mariam, Lamia, and Aisha, all of whom are friends with Zainab. Therefore, Zainab is suggested to Huda as a potential friend.

### Task 6️⃣ [1 mark]:  
**Description**: Implement `peopleYouMayKnowList/2` to get a list of all unique possible friends if a person shares at least one mutual friend with them. Ensure that the suggested friends are not already direct friends.

**Examples**:  
```prolog
?- peopleYouMayKnowList(ahmed, L).
L = [mohammed, said, omar, abdullah].

?- peopleYouMayKnowList(huda, L).
L = [hagar, zainab, hend].
```

### Bonus Task [1 mark]:  
**Description**: Implement `peopleYouMayKnow_indirect/2` to suggest possible friends through an indirect relation (e.g., X is a friend of Y, Y is a friend of Z, and Z is a friend of W, so suggest W to X). Ensure that the suggested friends are not already direct friends.

**Examples**:  
```prolog
?- peopleYouMayKnow_indirect(ahmed, X).
X = khaled;
X = ibrahim;
X = khaled;
...

?- peopleYouMayKnow_indirect(huda, X).
X = rokaya;
X = eman;
...
```
### 📤🔑 Important Remarks & Submission Notes

- Don’t change the structure of "data.pl".
- Write your solution in a different file not in "data.pl".
- Don't use any built-in predicates.
- Use the cut operator in the suitable positions when needed.

---

### 🛠️ Programming Language and Development Tools Used

<table align="center" border="1" cellpadding="10">
  <thead>
    <tr>
      <th>Programming Language</th>
      <th>Development Tool</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">
        -
      </td>
      <td align="center">
        <img src="https://github.com/user-attachments/assets/760710c4-f143-4afd-be7d-f0a8fffb7a54" title="SWI Prolog" alt="SWI Prolog" width="100" height="50"/>
      </td>
    </tr>
    <tr>
      <td align="center">
        Prolog
      </td>
      <td align="center">
        SWI Prolog
      </td>
    </tr>
  </tbody>
</table>

---

## 💬 Let's Connect
Feel free to reach out to me if you'd like to collaborate on a project or discuss technology! As a Software Engineer, I'm always open to tackling new challenges, sharing knowledge, and growing through collaborative opportunities.

**Mootaz Medhat Ezzat Abdelwahab**  
🎓 Software Engineering Graduate | Faculty of Computers and Artificial Intelligence, Cairo University  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mootaz-medhat-ezzat-abdelwahab-377a60244)
