import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/scaffold_with_navbar.dart';
import 'package:omaliving/screens/account/Account.dart';
import 'package:omaliving/screens/address/address.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/checkout/Checkout.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/discover/discovers.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/my_orders/Myorders.dart';
import 'package:omaliving/screens/newsletter/news_letter.dart';
import 'package:omaliving/screens/order_success/OrderSuccess.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/reset_password/reset_password.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';

// Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
        // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
        return ScaffoldWithNavbar(navigationShell);
      },
      branches: [
        // The route branch for the 1º Tab
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          // Add this branch routes
          // each routes with its sub routes if available e.g feed/uuid/details
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'pdp',
                  builder: (context, state) {
                    return const ProductListing(
                      id: 8989,
                    );
                  },
                )
              ],
            ),
          ],
        ),

        // The route branch for 2º Tab
        StatefulShellBranch(routes: <RouteBase>[
          // Add this branch routes
          // each routes with its sub routes if available e.g shope/uuid/details
          GoRoute(
            path: '/discover',
            builder: (context, state) {
              return const Discover();
            },
          ),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          // Add this branch routes
          // each routes with its sub routes if available e.g shope/uuid/details
          GoRoute(
            path: '/wishlist',
            builder: (context, state) {
              return const Wishlist();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'pdp',
                builder: (context, state) {

                  // Map<String, String> args =
                  // state.extra as Map<String, String>;

                  print(state.extra);
                  return  DetailsScreen(
                    product : state.extra.toString(),
                  );
                },
              )
            ],
          ),
        ]),

        StatefulShellBranch(routes: <RouteBase>[
          // Add this branch routes
          // each routes with its sub routes if available e.g shope/uuid/details
          GoRoute(
              path: '/cart',
              builder: (context, state) {
                return const CartScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'continue',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (BuildContext context, GoRouterState state) {
                    return const Checkout();
                  },
                ),
                GoRoute(
                  path: 'pdp',
                  builder: (context, state) {

                    // Map<String, String> args =
                    // state.extra as Map<String, String>;

                    print(state.extra);
                    return  DetailsScreen(
                      product : state.extra.toString(),
                    );
                  },
                )

              ]),
        ]),

        StatefulShellBranch(routes: <RouteBase>[
          // Add this branch routes
          // each routes with its sub routes if available e.g shope/uuid/details
          GoRoute(
            path: '/profile',
            builder: (context, state) {
              return const ProfileScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'account',
                builder: (context, state) {
                  return const Account();
                },
              ),
              GoRoute(
                path: 'myorders',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const MyOrders();
                },
              ),
              GoRoute(
                path: 'address',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const AddEditAddress();
                },
              ),
              GoRoute(
                path: 'resetpassword',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const ResetPassword();
                },
              ),
              GoRoute(
                path: 'news',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const Newsletter();
                },
              ),
              GoRoute(
                path: 'settings',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const Settings();
                },
              ),
            ],
          ),
        ]),


        StatefulShellBranch(routes: <RouteBase>[
          // Add this branch routes
          // each routes with its sub routes if available e.g shope/uuid/details
          GoRoute(
            path: '/profile',
            builder: (context, state) {
              return const ProfileScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'account',
                builder: (context, state) {
                  return const Account();
                },
              ),
              GoRoute(
                path: 'myorders',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const MyOrders();
                },
              ),
              GoRoute(
                path: 'address',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const AddEditAddress();
                },
              ),
              GoRoute(
                path: 'resetpassword',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const ResetPassword();
                },
              ),
              GoRoute(
                path: 'news',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const Newsletter();
                },
              ),
              GoRoute(
                path: 'settings',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return const Settings();
                },
              ),
            ],
          ),
        ]),
      ],
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        return const Account();
      },
    ),

    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),

  ],
);
