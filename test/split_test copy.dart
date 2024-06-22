import 'package:flutter_test/flutter_test.dart';
import 'package:splity_z/shared/models/models.dart';

void main() {
  final john = SpliteeImpl(name: 'John Doe', expensesTypes: []);
  final jane = SpliteeImpl(name: 'Jane Doe', expensesTypes: []);
  final jack = SpliteeImpl(name: 'Jack Reacher', expensesTypes: []);
  final andre = SpliteeImpl(name: 'André Rieu', expensesTypes: []);

  group('Test getShares with a simple split between 3 splitees', () {
    final split = SplitImpl(
      id: 1,
      name: 'Diner at the end of the world',
      splitees: <SpliteeImpl>[
        john,
        jane,
        jack,
      ],
      expenses: <Expense>[
        Expense.withPaidForList(name: 'Expense 1', amount: 30, paidBy: john, paidFor: [john, jane, jack]),
        Expense.withPaidForList(name: 'Expense 2', amount: 20, paidBy: john, paidFor: [john]),
        Expense.withPaidForList(name: 'Expense 3', amount: 15, paidBy: jack, paidFor: [john]),
      ],
    );

    test('It returns the right number of shares', () {
      final List<Share> shares = split.getShares();
      expect(shares.length, 2);
    });

    test('There is one share from John to Jack', () {
      final List<Share> shares = split.getShares();
      final johnShare = shares.where((share) => share.from == john).firstOrNull;

      expect(johnShare, isNotNull);
      expect(johnShare!.from, john);
      expect(johnShare.to, jack);
    });

    test('John\'s owes Jack 5', () {
      final List<Share> shares = split.getShares();
      final johnShare = shares.where((share) => share.from == john).firstOrNull;

      expect(johnShare!.amount, equals(5.0));
    });

    test('There is one share from Jane to John', () {
      final List<Share> shares = split.getShares();

      final janeShare = shares.where((share) => share.from == jane).firstOrNull;

      expect(janeShare, isNotNull);
      expect(janeShare!.from, jane);
    });

    test('Jane\'s owes John 10', () {
      final List<Share> shares = split.getShares();
      final janeShare = shares.where((share) => share.from == jane).firstOrNull;

      expect(janeShare!.amount, equals(10.0));
    });

    test('Jack has nothing to pay', () {
      final List<Share> shares = split.getShares();

      final jackShare = shares.where((share) => share.from == jack).firstOrNull;

      expect(jackShare, isNull);
    });
  });

  group('Test getShares with 4 splitees', () {
    final split = SplitImpl(
      id: 1,
      name: 'Diner at the end of the world',
      splitees: <SpliteeImpl>[
        john,
        jane,
        jack,
        andre,
      ],
      expenses: <Expense>[
        Expense.withPaidForList(
          name: 'Expense 1',
          amount: 56,
          paidBy: john,
          paidFor: [john, jane, jack, andre],
        ), // 14 per pax
        Expense.withPaidForList(
          name: 'Expense 2',
          amount: 37,
          paidBy: john,
          paidFor: [jane, jack],
        ), // 18.5 per pax
        Expense.withPaidForList(
          name: 'Expense 3',
          amount: 15,
          paidBy: andre,
          paidFor: [john, jane, jack],
        ), // 5 per pax
        Expense.withPaidForList(
          name: 'Expense 4',
          amount: 18,
          paidBy: andre,
          paidFor: [andre, jane],
        ), // 9 per pax
      ],
    );

    /*
      Jane -> John = 14 + 18.5 = 42.5 - 5(john) = 38.5
      Jane -> Andre = 5 + 9 = 14 + 5(John) = 19
      Jack -> John = 14 + 18.5 = 42.5
      Jack -> Andre = 5
      John -> Andre = 5 = 0(paid by Jane)
      Andre -> John = 14
      
    */

    test('It returns the right number of shares', () {
      final List<Share> shares = split.getShares();
      expect(shares.length, 4);
    });

    test('Jane owes John 41.5', () {
      final List<Share> shares = split.getShares();

      final janeToJohn = shares.where((share) {
        return share.from == jane && share.to == john;
      }).firstOrNull;

      expect(janeToJohn, isNotNull);
      expect(janeToJohn!.amount, equals(41.5));
    });

    test('Jane owes Andre 5', () {
      final List<Share> shares = split.getShares();

      final janeToAndre = shares.where((share) {
        return share.from == jane && share.to == andre;
      }).firstOrNull;

      expect(janeToAndre, isNotNull);
      expect(janeToAndre!.amount, equals(5));
    });

    test('Jack owes John 32.5', () {
      final List<Share> shares = split.getShares();

      final jackToJohn = shares.where((share) {
        return share.from == jack && share.to == john;
      }).firstOrNull;

      expect(jackToJohn, isNotNull);
      expect(jackToJohn!.amount, equals(32.5));
    });

    test('Jack owes Andre 5', () {
      final List<Share> shares = split.getShares();

      final jackToAndre = shares.where((share) {
        return share.from == jack && share.to == andre;
      }).firstOrNull;

      expect(jackToAndre, isNotNull);
      expect(jackToAndre!.amount, equals(5));
    });

    test('Andre has nothing to pay', () {
      final List<Share> shares = split.getShares();

      final andreShare = shares.where((share) => share.from == andre).firstOrNull;

      expect(andreShare, isNull);
    });

    test('John has nothing to pay', () {
      final List<Share> shares = split.getShares();

      final johnShare = shares.where((share) => share.from == john).firstOrNull;

      expect(johnShare, isNull);
    });
  });
}
