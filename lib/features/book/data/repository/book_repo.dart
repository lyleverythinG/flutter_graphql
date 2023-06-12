import 'package:flutter_graphql/core/graphql/config.dart';
import 'package:flutter_graphql/features/book/domain/model/book.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BookRepo {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  static GraphQLClient client = graphQLConfig.clientToQuery();

  static Future<List<BookModel>> getBooks() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
          query Query {
            getBooks {
              _id
              author
              title
              year
            }
          }
        """),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List? res = result.data?['getBooks'];

        if (res == null || res.isEmpty) {
          return [];
        }

        List<BookModel> books =
            res.map((book) => BookModel.fromMap(map: book)).toList();

        return books;
      }
    } catch (error) {
      return [];
    }
  }

  static Future<String?> createBook({
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
        // Returns the id
        return result.data?['createBook'] as String?;
      }
    } catch (error) {
      return null;
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

  static Future<bool> deleteBook({required String id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            mutation Mutation(\$id: ID!) {
              deleteBook(ID: \$id)
            }
          """),
          variables: {
            "id": id,
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
}
