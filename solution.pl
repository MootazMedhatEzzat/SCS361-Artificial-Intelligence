% Facts from data.pl that define friendships
% Each 'friend' fact describes a one-way friendship, where the first person is friends with the second person.
friend(ahmed, samy).
friend(ahmed, fouad).
friend(samy, mohammed).
friend(samy, said).
friend(samy, omar).
friend(samy, abdullah).
friend(fouad, abdullah).
friend(abdullah, khaled).
friend(abdullah, ibrahim).
friend(abdullah, omar).
friend(mostafa, marwan).
friend(marwan, hassan).
friend(hassan, ali).

friend(hend, aisha).
friend(hend, mariam).
friend(hend, khadija).
friend(huda, mariam).
friend(huda, aisha).
friend(huda, lamia).
friend(mariam, hagar).
friend(mariam, zainab).
friend(aisha, zainab).
friend(lamia, zainab).
friend(zainab, rokaya).
friend(zainab, eman).
friend(eman, laila).

% This predicate defines the symmetric friendship relation.
% If X is a friend of Y, then Y is also a friend of X.
is_friend(X, Y) :-
    friend(X, Y).  % Checks if X is friends with Y in the knowledge base.
is_friend(X, Y) :-
    friend(Y, X).  % Also checks if Y is friends with X, making the relation bidirectional.

% Custom member function to check if X is in the list.
% my_member(X, [X | _]) succeeds if X is the head of the list.
my_member(X, [X | _]) :- !.  % The cut operator (!) prevents further backtracking once X is found.
% If X is not the head, we recursively check the rest of the list (Ys).
my_member(X, [_ | Ys]) :-
    my_member(X, Ys).

% Generates a list of friends for a given person X using an accumulator (Acc).
% friend_list(X, Acc, Xs) is true if Xs is the list of friends of X.
friend_list(X, Acc, Xs) :-
    is_friend(X, Y),        % Find a friend Y of X.
    \+ my_member(Y, Acc),   % Ensure Y is not already in the accumulator to avoid duplicates.
    !,                      % Prevent further attempts to find Y again.
    friend_list(X, [Y | Acc], Xs).  % Recursively build the friend list.
friend_list(_, Acc, Acc).  % Base case: When no more friends are found, return the accumulator.
% This is the public version of the predicate that initializes with an empty accumulator.
friend_list(X, Xs) :- friend_list(X, [], Xs).

% Counts the number of elements in a list.
% count([], Acc, Acc) succeeds when the list is empty, returning the accumulated count.
count([], Acc, Acc).  % Base case: When the list is empty, return the accumulator.
% For each element, increment the accumulator and continue counting.
count([_ | Xs], Acc, N) :-
    Accp is Acc + 1,   % Accumulate the count.
    count(Xs, Accp, N).
% Public version of the count predicate that starts with 0.
count(Xs, N) :- count(Xs, 0, N).

% Counts the number of friends for a given person.
friend_list_count(X, N) :-
    friend_list(X, Ys),   % Get the friend list.
    count(Ys, Np),        % Count the number of friends.
    N is Np.              % Return the final count.

% Suggests possible friends to X by checking mutual friends.
people_you_may_know(X, Y) :-
    is_friend(X, Z),      % Find a mutual friend Z.
    is_friend(Z, Y),      % Z is also friends with Y.
    \+(X=Y),              % Ensure X and Y are not the same person.
    \+is_friend(X, Y).    % Ensure X and Y are not already friends.

% Concatenates lists of friends of friends.
concatenate_friend_lists([], []).  % Base case: If the input list is empty, return an empty list.
% Recursively get the friend list for each person and concatenate.
concatenate_friend_lists([X | Xs], [Y | Ys]) :-
    friend_list(X, Y),                % Get the friend list for person X.
    concatenate_friend_lists(Xs, Ys).  % Continue with the rest of the list.

% Appends two lists.
my_append([], Ys, Ys).  % Base case: If the first list is empty, return the second list.
my_append([X | Xs], Ys, [X | Zs]) :- 
    my_append(Xs, Ys, Zs).  % Recursively append elements of the first list to the second.

% Flattens a list of lists into a single list.
my_flatten([], []).  % Base case: If the input is an empty list, return an empty list.
my_flatten([X | Xs], Ys) :-
    my_flatten(Xs, Zs),  % Recursively flatten the rest of the list.
    my_append(X, Zs, Ys).  % Append the flattened list to the result.

% Removes duplicates from a list.
remove_duplicates([X | Xs], Ys) :-
    my_member(X, Xs),    % If X appears later in the list, skip it.
    !,
    remove_duplicates(Xs, Ys).
remove_duplicates([X | Xs], [X | Ys]) :-
    \+my_member(X, Xs),  % If X is not a duplicate, keep it.
    remove_duplicates(Xs, Ys).
remove_duplicates([], []).  % Base case: If the list is empty, return an empty list.

% Removes direct friends and the person themselves from a list.
remove_friends_and_self(X, [Y | Ys], [Y | Zs]) :-
    \+is_friend(X, Y),   % If Y is not a friend of X and Y is not X themselves, keep it.
    \+(X = Y),
    !,
    remove_friends_and_self(X, Ys, Zs).  % Continue with the rest of the list.
remove_friends_and_self(X, [_ | Ys], Zs) :- 
    !,
    remove_friends_and_self(X, Ys, Zs).  % Skip friends.
remove_friends_and_self(_, [], []).  % Base case: If the list is empty, return an empty list.

% Counts how many times X appears in a list.
count_occurrences(_, [], Acc, Acc).  % Base case: When the list is empty, return the count.
count_occurrences(X, [X | Xs], Acc, N) :-
    Accp is Acc + 1,
    count_occurrences(X, Xs, Accp, N).  % Increment the count if X is found.
count_occurrences(X, [_ | Xs], Acc, N) :-
    count_occurrences(X, Xs, Acc, N).  % Skip elements that are not X.
count_occurrences(X, Xs, N) :- count_occurrences(X, Xs, 0, N).  % Public version.

% Finds friends of friends for a given person.
friends_of_friends(X, Ns) :-
    friend_list(X, Xs),              % Get the friend list of X.
    concatenate_friend_lists(Xs, Ys), % Get the friend lists of X's friends.
    my_flatten(Ys, Zs),              % Flatten the list of lists into a single list.
    remove_friends_and_self(X, Zs, Ns).  % Remove X's direct friends and X from the list.

% Suggests friends with at least N mutual friends.
people_you_may_know(X, N, Y) :-
    friends_of_friends(X, Xs),       % Get friends of friends.
    count_occurrences(Y, Xs, N),     % Check if Y appears at least N times.
    !.  % Only return one result, as required.

% Lists all possible friends with at least one mutual friend.
people_you_may_know_list(X, Xs) :-
    friends_of_friends(X, Ys),       % Get friends of friends.
    remove_duplicates(Ys, Xs).       % Remove duplicates from the result.

% Checks if a suggestion is applicable for indirect connections.
indirect_applicable(X, Acc, Y) :-
    \+my_member(Y, Acc),            % Ensure Y is not already in the accumulator.
    \+(is_friend(X, Y)),            % Ensure Y is not already a friend.
    \+(X=Y),                        % Ensure Y is not X themselves.
    \+people_you_may_know(X, Y).    % Ensure Y is not suggested by direct mutual friends.

% Suggests friends via indirect connections (friend of a friend of a friend).
people_you_may_know_indirect(X, Acc, Y) :-
    is_friend(X, Z),                % Find a friend Z of X.
    is_friend(Z, W),                % Find a friend W of Z.
    is_friend(W, Y),                % Find a friend Y of W.
    indirect_applicable(X, Acc, Y).  % Ensure Y is applicable for suggestion.

% Additional indirect connection handling.
people_you_may_know_indirect(X, Y) :- people_you_may_know_indirect(X, [], Y).