import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../lib.dart';

class ChangedArtistPage extends StatelessWidget {
  const ChangedArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetArtistsCubit>()..getArtists(),
      child: BlocBuilder<GetArtistsCubit, GetArtistsState>(
        builder: (context, state) {
          if (state is GetArtistsError) {
            return Text(state.message as String);
          }

          if (state is GetArtistsLoaded) {
            return _ChangedArtistWrapper(artists: state.filtered);
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}

class _ChangedArtistWrapper extends StatelessWidget {
  const _ChangedArtistWrapper({required this.artists});

  final List<ArtistEntity>? artists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: ColumnPadding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Artists', style: AppTextStyle.bold.copyWith(fontSize: 18)),
          Text(
            TextConstant.explanationArtist,
            style: AppTextStyle.regular.copyWith(fontSize: 12),
          ),
          Gap(height: 10),
          CustomSearchWithoutSuffixIcon(
            onChanged: (value) {
              context.read<GetArtistsCubit>().searchArtists(value);
            },
          ),
          const Gap(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: artists?.length ?? 0,
              itemBuilder: (context, index) {
                return Builder(
                  builder: (context) {
                    return _ArtistCard(
                      isSelected: context.select<GetDataCubit, bool>(
                        (cubit) =>
                            cubit.state.identifier ==
                            artists?[index].identifier,
                      ),
                      title: artists?[index].name ?? 'No Artist found',
                      subtitle: artists?[index].englishName ?? '',
                      onTap: () {
                        context.read<GetDataCubit>().changedArtist(
                          identifier: artists?[index].identifier ?? '',
                          name: artists?[index].englishName ?? '',
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Change artist ${artists?[index].englishName ?? ''} ",
                              ),
                            ),
                          );
                        }

                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtistCard extends StatelessWidget {
  const _ArtistCard({
    required String title,
    required String subtitle,
    void Function()? onTap,
    required bool isSelected,
  }) : _title = title,
       _subtitle = subtitle,
       _onTap = onTap,
       _isSelected = isSelected;

  final String _title;
  final String _subtitle;
  final void Function()? _onTap;
  final bool _isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      shape: _isSelected
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.tertiary.withValues(),
                width: 0.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            )
          : null,
      child: ListTile(
        leading: _avatar(theme, selected: _isSelected),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: Text(_title, style: AppTextStyle.medium.copyWith(fontSize: 14)),
        subtitle: Text(
          _subtitle,
          style: AppTextStyle.regular.copyWith(
            fontSize: 12,
            color: theme.tertiary,
          ),
        ),
        trailing: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.3,
          ),
          child: _isSelected
              ? Icon(Icons.radio_button_on, color: theme.tertiary)
              : SizedBox.shrink(),
        ),
        onTap: _onTap,
      ),
    );
  }

  Widget _avatar(ColorScheme theme, {required bool selected}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 60, maxHeight: 60),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.tertiary),
            ),
            child: CustomImageWrapper(
              image: AppIcons.avatar,
              isNetworkImage: false,
              width: 50,
              height: 50,
            ),
          ),
          selected
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.tertiary,
                    ),
                    child: Icon(Icons.mic, size: 12),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
