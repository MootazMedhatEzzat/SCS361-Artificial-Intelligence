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

%=========================================%
% TASK 1: Symmetric Friend Relation       %
%=========================================%
% This predicate checks friendship in both directions.
% If X is a friend of Y, then Y is also a friend of X.
is_friend(X, Y) :- friend(X, Y).  % Checks if X is a friend of Y in the knowledge base.
is_friend(X, Y) :- friend(Y, X).  % Also checks if Y is a friend of X, making the relation bidirectionals.

%=========================================%
% TASK 2: Friend List                     %
%=========================================%
% This predicate generates a list of all unique friends for a given person X using an accumulator (Acc).
% - Uses an accumulator (Acc) to track friends and ensure uniqueness.
% - Clause order and cuts ensure a single solution with the full list.
friendList(X, Friends) :- friendListHelper(X, [], Friends).  % Start with empty accumulator

% Recursive helper predicate:
% - Recursive clause is first, so Prolog prioritizes finding friends over returning results.
% - Aggressively accumulates unique friends into Acc until no more are found.
friendListHelper(X, Acc, Friends) :-
    is_friend(X, Y),        % Find a friend Y of X.
    \+ member(Y, Acc),      % Check if Y is NOT in the accumulator to avoid duplicates.
    !,                      % Cut: Prevent backtracking to keep Y unique (Prevent further attempts to find Y again).
    friendListHelper(X, [Y | Acc], Friends).  % Recurse with the updated list.

% Base case:
% - Only reached when no more friends can be found (due to cut in recursive clause).
% - Unifies the final accumulated list (Friends) with the result.
friendListHelper(_, Friends, Friends).

% This predicate checks if an element is a member of a list. Checks if X is in the list
member(X, [X | _]) :- !.  % Succeeds if X is the head of the list. The cut operator (!) prevents further backtracking once X is found.
member(X, [_ | Ys]) :- member(X, Ys). % If X is not the head, we recursively check the rest of the list (Ys). Recurse on tail.

%=========================================%
% TASK 3: Friend Count (Tail Recursion)   %
%=========================================%
% This predicate counts friends using tail recursion for efficiency.
friendListCount(X, N) :-
    friendList(X, Friends),   % Get friend list first.
    countTail(Friends, 0, N). % Count using tail recursion.

% Base case: Accumulator holds the final count.
countTail([], Acc, Acc).      % Returns accumulated count.

% Recursive case: Increment accumulator for each friend.
countTail([_ | T], Acc, N) :-
    Acc1 is Acc + 1,          % Increment counter.
    countTail(T, Acc1, N).    % Tail-recursive call

%=========================================%
% TASK 4: Suggest Friends with Mutuals    %
%=========================================%
%  This predicate suggests Z to X if X and Z share at least one mutual friend (Y).
peopleYouMayKnow(X, Z) :-
    is_friend(X, Y),          % X is friends with Y.
    is_friend(Y, Z),          % Y is friends with Z.
    X \= Z,                   % Ensure Z is not X.
    \+ is_friend(X, Z).       % Ensure Z is not already a friend of X.

%=========================================%
% TASK 5: N Mutual Friends Suggestion     %
%=========================================%
%  This predicate suggests Z to X if X and Z have at least N mutual friends.
peopleYouMayKnow(X, N, Z) :-
    peopleYouMayKnow(X, Z),    % Z is a candidate (as in Task 4).
    countMutuals(X, Z, Count), % Count mutual friends.
    Count >= N,                % Check if count meets threshold.
    !.

% Count mutual friends between X and Z.
countMutuals(X, Z, Count) :-
    countMutualsHelper(X, Z, [], 0, Count).

% Helper predicate with Seen list to track counted friends
countMutualsHelper(X, Z, Seen, Acc, Count) :-
    is_friend(X, Y),          % Find a mutual friend Y
    is_friend(Y, Z),
    \+ member(Y, Seen),       % Ensure Y hasn't been counted
    !,                        % Cut to commit to this Y
    NewAcc is Acc + 1,
    countMutualsHelper(X, Z, [Y | Seen], NewAcc, Count).

countMutualsHelper(_, _, _, Count, Count).  % Base case returns accumulated count

%=========================================%
% TASK 6: Unique Suggested Friends List   %
%=========================================%
% This predicate generates a list of all unique suggested friends for a given person X using an accumulator (Acc).
% - Uses an accumulator (Acc) to track friends and ensure uniqueness.
% - Clause order and cuts ensure a single solution with the full list.
peopleYouMayKnowList(X, SuggestedFriends) :- collectUnique(X, [], SuggestedFriends).  % Start with empty accumulator.

% Recursive helper predicate:
% - Recursive clause is first, so Prolog prioritizes finding friends over returning results.
% - Aggressively accumulates unique suggested friends into Acc until no more are found.
collectUnique(X, Acc, SuggestedFriends) :-
    peopleYouMayKnow(X, Z),   % Find a suggestion.
    \+ member(Z, Acc),        % Check if Z is NOT in the accumulator to avoid duplicates.
    !,                        % Cut: Prevent backtracking to keep Z unique (Prevent further attempts to find Z again).
    collectUnique(X, [Z | Acc], SuggestedFriends).  % Recurse with the updated Acc.

% Base case:
% - Only reached when no more suggested friends can be found (due to cut in recursive clause).
% - Unifies the final accumulated list (SuggestedFriends) with the result.
collectUnique(_, SuggestedFriends, SuggestedFriends).

%=========================================%
% BONUS: Indirect Friend Suggestions      %
%=========================================%
% % This predicate suggests W if connected via a chain (X->Y->Z->W) with no direct mutuals.
peopleYouMayKnow_indirect(X, W) :-
    is_friend(X, Y),          % Check if X is friends with Y.
    is_friend(Y, Z),          % Check if Y is friends with Z.
    is_friend(Z, W),          % Check if Z is friends with W.
    X \= W,                   % Ensure W is not X.
    \+ is_friend(X, W),       % W is not already a friend.
    \+ hasMutual(X, W).       % No direct mutual friends.

% Check if X and W have any mutual friends.
hasMutual(X, W) :-
    is_friend(X, Y),          % Check if X is friends with Y.
    is_friend(Y, W).          % Check if Y is friends with W.
