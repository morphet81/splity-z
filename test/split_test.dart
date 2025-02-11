import 'package:flutter_test/flutter_test.dart';
import 'package:splity_z/shared/models/models.dart';

void main() {
  final john = Splitee.withoutId(name: 'John Doe', expensesTypes: []);
  final jane = Splitee.withoutId(name: 'Jane Doe', expensesTypes: []);
  final jack = Splitee.withoutId(name: 'Jack Reacher', expensesTypes: []);
  final andre = Splitee.withoutId(name: 'André Rieu', expensesTypes: []);

  group('Test getShares', () {
    group('Test getShares with a simple split between 3 splitees', () {
      final split = Split(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[
          john,
          jane,
          jack,
        ],
        expenses: <Expense>[
          Expense.withPaidForList(
            name: 'First expense',
            amount: 30,
            paidBy: john,
            paidFor: [john, jane, jack],
          ),
          Expense.withPaidForList(
            name: 'Second expense',
            amount: 20,
            paidBy: john,
            paidFor: [john],
          ),
          Expense.withPaidForList(
            name: 'Third expense',
            amount: 15,
            paidBy: jack,
            paidFor: [john],
          ),
        ],
      );

      test('It returns the right number of shares', () {
        final List<Share> shares = split.getShares();
        expect(shares.length, 2);
      });

      test('There is one share from John to Jack', () {
        final List<Share> shares = split.getShares();
        final johnShare = shares
            .where((share) => share.from == john && share.to == jack)
            .firstOrNull;

        expect(johnShare, isNotNull);
        expect(johnShare!.from, john);
        expect(johnShare.to, jack);
      });

      test('John owes Jack 5', () {
        final List<Share> shares = split.getShares();
        final johnShare = shares
            .where((share) => share.from == john && share.to == jack)
            .firstOrNull;

        expect(johnShare!.amount, equals(5.0));
      });

      test('There is one share from Jane to John', () {
        final List<Share> shares = split.getShares();

        final janeShare = shares
            .where((share) => share.from == jane && share.to == john)
            .firstOrNull;

        expect(janeShare, isNotNull);
        expect(janeShare!.from, jane);
      });

      test('Jane owes John 10', () {
        final List<Share> shares = split.getShares();
        final janeShare = shares
            .where((share) => share.from == jane && share.to == john)
            .firstOrNull;

        expect(janeShare!.amount, equals(10.0));
      });

      test('Jack has nothing to pay', () {
        final List<Share> shares = split.getShares();

        final jackShare =
            shares.where((share) => share.from == jack).firstOrNull;

        expect(jackShare, isNull);
      });
    });

    group(
        'Test getShares between 4 splitees that should simplify down to 4 shares',
        () {
      final split = Split(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[john, jane, jack, andre],
        expenses: <Expense>[
          Expense.withPaidForList(
            name: 'First expense',
            amount: 56,
            paidBy: john,
            paidFor: [john, jane, jack, andre],
          ), // 14 per pax
          Expense.withPaidForList(
            name: 'Second expense',
            amount: 37,
            paidBy: john,
            paidFor: [jane, jack],
          ), // 18.5 per pax
          Expense.withPaidForList(
            name: 'Third expense',
            amount: 15,
            paidBy: andre,
            paidFor: [john, jane, jack],
          ), // 5 per pax
          Expense.withPaidForList(
            name: 'Fourth expense',
            amount: 18,
            paidBy: andre,
            paidFor: [andre, jane],
          ), // 9 per pax
          Expense.withPaidForList(
            name: 'Fifth expense',
            amount: 4,
            paidBy: andre,
            paidFor: [jack],
          ), // 4 per pax
        ],
      );

      /*
      WITHOUT SIMPLIFICATION: 
      jack -> andre = 5 + 4 =                       9
      jack -> john = 14 + 18.5 =                    32.5
      jane -> andre = 5 + 9 =                       14
      jane -> john = 14 + 18.5 =                    32.5
      andre -> john = 14 - 5 =                      9
      john -> andre = 5 - 5 decrease for andre =    0
    */

      /*
      WITH SIMPLIFICATION: 
      jack -> andre = 5 + 4 = 9 - 9 paid by jane =          0
      jack -> john = 14 + 18.5 = 32.5 + 9 paid for jane =   41.5
      jane -> andre = 5 + 9 = 14 + 9 paid for jack =        23
      jane -> john = 14 + 18.5 = 32.5 - 9 paid by jack      23.5
      andre -> john = 14 - 5 =                              9
      john -> andre = 5 - 5 decrease for andre =            0
    */

      test('It returns the right number of shares', () {
        final List<Share> shares = split.getShares();
        expect(shares.length, 4);
      });

      test('Jane owes John 23.5', () {
        final List<Share> shares = split.getShares();

        final janeToJohn = shares.where((share) {
          return share.from == jane && share.to == john;
        }).firstOrNull;

        expect(janeToJohn, isNotNull);
        expect(janeToJohn!.amount, equals(23.5));
      });

      test('Jane owes Andre 23', () {
        final List<Share> shares = split.getShares();

        final janeToAndre = shares.where((share) {
          return share.from == jane && share.to == andre;
        }).firstOrNull;

        expect(janeToAndre, isNotNull);
        expect(janeToAndre!.amount, equals(23));
      });

      test('Jack owes John 41.5', () {
        final List<Share> shares = split.getShares();

        final jackToJohn = shares.where((share) {
          return share.from == jack && share.to == john;
        }).firstOrNull;

        expect(jackToJohn, isNotNull);
        expect(jackToJohn!.amount, equals(41.5));
      });

      test('Andre owes John 9', () {
        final List<Share> shares = split.getShares();

        final andreToJohn = shares.where((share) {
          return share.from == andre && share.to == john;
        }).firstOrNull;

        expect(andreToJohn, isNotNull);
        expect(andreToJohn!.amount, equals(9));
      });

      test('John has nothing to pay', () {
        final List<Share> shares = split.getShares();

        final johnShare =
            shares.where((share) => share.from == john).firstOrNull;

        expect(johnShare, isNull);
      });
    });

    group(
        'Test getShares between 4 splitees do not simplify further when amounts to balance are equal and amounts to balance have the same payee',
        () {
      final split = Split(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[john, jane, jack, andre],
        expenses: <Expense>[
          Expense.withPaidForList(
            name: 'First expense',
            amount: 56,
            paidBy: john,
            paidFor: [john, jane, jack, andre],
          ), // 14 per pax
          Expense.withPaidForList(
            name: 'Second expense',
            amount: 37,
            paidBy: john,
            paidFor: [jane, jack],
          ), // 18.5 per pax
          Expense.withPaidForList(
            name: 'Third expense',
            amount: 15,
            paidBy: andre,
            paidFor: [john, jane, jack],
          ), // 5 per pax
          Expense.withPaidForList(
            name: 'Fourth expense',
            amount: 18,
            paidBy: andre,
            paidFor: [andre, jane],
          ), // 9 per pax
          Expense.withPaidForList(
            name: 'Fifth expense',
            amount: 9,
            paidBy: andre,
            paidFor: [jack],
          ), // 9 per pax
        ],
      );

      /*
      WITHOUT SIMPLIFICATION: 
      jack -> andre = 5 + 9 =                       14
      jack -> john = 14 + 18.5 =                    32.5
      jane -> andre = 5 + 9 =                       14
      jane -> john = 14 + 18.5 =                    32.5
      andre -> john = 14 - 5 =                      9
      john -> andre = 5 - 5 decrease for andre =    0
    */

      /*
      WITH SIMPLIFICATION: 
      jack -> andre = 5 + 9 = 14 - 14 paid by jane =          0
      jack -> john = 14 + 18.5 = 32.5 + 14 paid for jane =    46.5
      jane -> andre = 5 + 9 = 14 + 14 paid for jack =         28
      jane -> john = 14 + 18.5 = 32.5 - 14 paid by jack       18.5
      andre -> john = 14 - 5 =                                9
      john -> andre = 5 - 5 decrease for andre =              0
    */

      test('It returns the right number of shares', () {
        final List<Share> shares = split.getShares();
        expect(shares.length, 4);
      });

      test('Jane owes John 18.5', () {
        final List<Share> shares = split.getShares();

        final janeToJohn = shares.where((share) {
          return share.from == jane && share.to == john;
        }).firstOrNull;

        expect(janeToJohn, isNotNull);
        expect(janeToJohn!.amount, equals(18.5));
      });

      test('Jane owes Andre 28', () {
        final List<Share> shares = split.getShares();

        final janeToAndre = shares.where((share) {
          return share.from == jane && share.to == andre;
        }).firstOrNull;

        expect(janeToAndre, isNotNull);
        expect(janeToAndre!.amount, equals(28));
      });

      test('Jack owes John 46.5', () {
        final List<Share> shares = split.getShares();

        final jackToJohn = shares.where((share) {
          return share.from == jack && share.to == john;
        }).firstOrNull;

        expect(jackToJohn, isNotNull);
        expect(jackToJohn!.amount, equals(46.5));
      });

      test('Andre owes John 9', () {
        final List<Share> shares = split.getShares();

        final andreToJohn = shares.where((share) {
          return share.from == andre && share.to == john;
        }).firstOrNull;

        expect(andreToJohn, isNotNull);
        expect(andreToJohn!.amount, equals(9));
      });

      test('John has nothing to pay', () {
        final List<Share> shares = split.getShares();

        final johnShare =
            shares.where((share) => share.from == john).firstOrNull;

        expect(johnShare, isNull);
      });
    });

    group(
        'Test getShares between 4 splitees that should simplify down to 4 shares, even when balanced splitees are inverted (jane\'s balance is less than jack\'s)',
        () {
      final split = Split(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[john, jane, jack, andre],
        expenses: <Expense>[
          Expense.withPaidForList(
            name: 'First expense',
            amount: 56,
            paidBy: john,
            paidFor: [john, jane, jack, andre],
          ), // 14 per pax
          Expense.withPaidForList(
            name: 'Second expense',
            amount: 37,
            paidBy: john,
            paidFor: [jane, jack],
          ), // 18.5 per pax
          Expense.withPaidForList(
            name: 'Third expense',
            amount: 15,
            paidBy: andre,
            paidFor: [john, jane, jack],
          ), // 5 per pax
          Expense.withPaidForList(
            name: 'Fourth expense',
            amount: 18,
            paidBy: andre,
            paidFor: [andre, jane],
          ), // 9 per pax
          Expense.withPaidForList(
            name: 'Fifth expense',
            amount: 10,
            paidBy: andre,
            paidFor: [jack],
          ), // 10 per pax
        ],
      );

      /*
      WITHOUT SIMPLIFICATION: 
      jack -> andre = 5 + 10 =                      15
      jack -> john = 14 + 18.5 =                    32.5
      jane -> andre = 5 + 9 =                       14
      jane -> john = 14 + 18.5 =                    32.5
      andre -> john = 14 - 5 =                      9
      john -> andre = 5 - 5 decrease for andre =    0
    */

      /*
      WITH SIMPLIFICATION: 
      jack -> andre = 5 + 10 = 15 + 14 paid for jane =      29
      jack -> john = 14 + 18.5 = 32.5 - 14 paid by jane =   18.5
      jane -> andre = 5 + 9 = 14 - 14 paid by jack =        0
      jane -> john = 14 + 18.5 = 32.5 + 14 paid for jack =  46.5
      andre -> john = 14 - 5 =                              9
      john -> andre = 5 - 5 decrease for andre =            0
    */

      test('It returns the right number of shares', () {
        final List<Share> shares = split.getShares();
        expect(shares.length, 4);
      });

      test('Jack owes Andre 29', () {
        final List<Share> shares = split.getShares();

        final jackToAndre = shares.where((share) {
          return share.from == jack && share.to == andre;
        }).firstOrNull;

        expect(jackToAndre, isNotNull);
        expect(jackToAndre!.amount, equals(29));
      });

      test('Jack owes John 18.5', () {
        final List<Share> shares = split.getShares();

        final jackToJohn = shares.where((share) {
          return share.from == jack && share.to == john;
        }).firstOrNull;

        expect(jackToJohn, isNotNull);
        expect(jackToJohn!.amount, equals(18.5));
      });

      test('Jane owes John 46.5', () {
        final List<Share> shares = split.getShares();

        final janeToJohn = shares.where((share) {
          return share.from == jane && share.to == john;
        }).firstOrNull;

        expect(janeToJohn, isNotNull);
        expect(janeToJohn!.amount, equals(46.5));
      });

      test('Andre owes John 9', () {
        final List<Share> shares = split.getShares();

        final andreToJohn = shares.where((share) {
          return share.from == andre && share.to == john;
        }).firstOrNull;

        expect(andreToJohn, isNotNull);
        expect(andreToJohn!.amount, equals(9));
      });

      test('John has nothing to pay', () {
        final List<Share> shares = split.getShares();

        final johnShare =
            shares.where((share) => share.from == john).firstOrNull;

        expect(johnShare, isNull);
      });
    });

    group(
        'Test getShares between 4 splitees simplifies further when amounts to balance are equal and amounts to balance don\'t have the same payee',
        () {
      final split = Split(
        id: 1,
        name: 'Diner at the end of the world',
        splitees: <Splitee>[john, jane, jack, andre],
        expenses: <Expense>[
          Expense.withPaidForList(
            name: 'First expense',
            amount: 56,
            paidBy: john,
            paidFor: [john, jane, jack, andre],
          ), // 14 per pax
          Expense.withPaidForList(
            name: 'Second expense',
            amount: 37,
            paidBy: john,
            paidFor: [jane, jack],
          ), // 18.5 per pax
          Expense.withPaidForList(
            name: 'Third expense',
            amount: 15,
            paidBy: andre,
            paidFor: [john, jane, jack],
          ), // 5 per pax
          Expense.withPaidForList(
            name: 'Fourth expense',
            amount: 18,
            paidBy: andre,
            paidFor: [andre, jane],
          ), // 9 per pax
          Expense.withPaidForList(
            name: 'Fifth expense',
            amount: 20,
            paidBy: andre,
            paidFor: [jane],
          ), // 20 per pax
          Expense.withPaidForList(
            name: 'Sixth expense',
            amount: 27.5,
            paidBy: andre,
            paidFor: [jack],
          ), // 20 per pax
          Expense.withPaidForList(
            name: 'Seventh expense',
            amount: 10,
            paidBy: john,
            paidFor: [jack],
          ), // 10 per pax
        ],
      );

      /*
      WITHOUT SIMPLIFICATION: 
      jack -> andre = 5 + 27.5 =                    32.5
      jack -> john = 14 + 18.5 + 10 =               42.5
      jane -> john = 14 + 18.5 =                    32.5
      jane -> andre = 5 + 9 + 20 =                  34
      andre -> john = 14 - 5 =                      9
      john -> andre = 5 - 5 decrease for andre =    0
    */

      /*
      WITH SIMPLIFICATION: 
      jack -> andre = 5 + 27.5 =                    0
      jack -> john = 14 + 18.5 + 10 =               75
      jane -> john = 14 + 18.5 =                    0
      jane -> andre = 5 + 9 + 20 =                  66.5
      andre -> john = 14 - 5 =                      9
      john -> andre = 5 - 5 decrease for andre =    0
    */

      test('It returns the right number of shares', () {
        final List<Share> shares = split.getShares();
        expect(shares.length, 3);
      });

      test('Jack owes John 75', () {
        final List<Share> shares = split.getShares();

        final jackToJohn = shares.where((share) {
          return share.from == jack && share.to == john;
        }).firstOrNull;

        expect(jackToJohn, isNotNull);
        expect(jackToJohn!.amount, equals(75));
      });

      test('Jane owes Andre 66.5', () {
        final List<Share> shares = split.getShares();

        final janeToAndre = shares.where((share) {
          return share.from == jane && share.to == andre;
        }).firstOrNull;

        expect(janeToAndre, isNotNull);
        expect(janeToAndre!.amount, equals(66.5));
      });

      test('Andre owes John 9', () {
        final List<Share> shares = split.getShares();

        final andreToJohn = shares.where((share) {
          return share.from == andre && share.to == john;
        }).firstOrNull;

        expect(andreToJohn, isNotNull);
        expect(andreToJohn!.amount, equals(9));
      });

      test('John has nothing to pay', () {
        final List<Share> shares = split.getShares();

        final johnShare =
            shares.where((share) => share.from == john).firstOrNull;

        expect(johnShare, isNull);
      });
    });
  });
}
