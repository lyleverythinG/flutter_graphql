import 'package:flutter_graphql/core/graphql/config.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BookRepo {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static GraphQLClient client = graphQLConfig.clientToQuery();

  static Future<List<BookModel>> getBooks({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query(\$limit: Int) {
              getBooks(limit: \$limit) {
                _id
                author
                title
                year
              }
            }
            """),
          variables: {
            'limit': limit,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List? res = result.data?['getBooks'];

        if (res == null || res.isEmpty) {
          return [];
        }

        List<BookModel> feelings =
            res.map((feeling) => BookModel.fromMap(map: feeling)).toList();

        return feelings;
      }
    } catch (error) {
      return [];
    }
  }

  static Future<bool> createBook({
    required String title,
    required String author,
    required int year,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
              mutation Mutation(\$bookInput: BookInput) {
                createBook(bookInput: \$bookInput)
              }
            """),
          variables: {
            "bookInput": {
              "title": title,
              "author": author,
              "year": year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  static Future updateBook({
    required BookModel bookModel,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
              mutation Mutation(\$id: ID!, \$bookInput: BookInput) {
                updateBook(ID: \$id, bookInput: \$bookInput)
              }
            """,
          ),
          variables: {
            "id": bookModel.id,
            "bookInput": {
              "title": bookModel.title,
              "author": bookModel.author,
              "year": bookModel.year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
