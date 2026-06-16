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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Artists',
          style: AppTextStyle.medium.copyWith(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          CustomSearchWithoutSuffixIcon(
            onChanged: (value) {
              context.read<GetArtistsCubit>().searchArtists(value);
            },
          ),
          const Gap(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: artists?.length ?? 0,
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                        context.read<GetDataCubit>().setIdentifier(
                          identifier: artists?[index].identifier ?? '',
                        );

                        context.read<GetDataCubit>().setName(
                          name: artists?[index].englishName ?? '',
                        );
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
      child: ListTile(
        leading: CircleAvatar(maxRadius: 25, child: Icon(Icons.mic, size: 20)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: Text(_title, style: AppTextStyle.medium.copyWith(fontSize: 14)),
        subtitle: Text(
          _subtitle,
          style: AppTextStyle.medium.copyWith(fontSize: 12),
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
}
