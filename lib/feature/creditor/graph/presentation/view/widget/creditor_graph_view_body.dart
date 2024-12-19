import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../home/data/model/creditor_installment_model.dart';
import '../../../../home/presentation/view_model/cubit/creditor_installment_cubit.dart';
import '../../../../home/presentation/view_model/cubit/creditor_installment_state.dart';

class CreditorGraphViewBody extends StatefulWidget {
  const CreditorGraphViewBody({super.key});

  @override
  State<CreditorGraphViewBody> createState() => _CreditorGraphViewBodyState();
}

class _CreditorGraphViewBodyState extends State<CreditorGraphViewBody> {
  late String selectedFilter;

  List<BarChartGroupData> getBarData(
      List<CreditorInstallmentModel> installments) {
    List<BarChartGroupData> barData = [];
    for (int i = 0; i < installments.length; i++) {
      double totalPaid = installments[i].totalPaid;
      // double totalAmount = installments[i].totalAmount;
      double remainingAmount = installments[i].totalAmount - totalPaid;
      double adjustedTotalPaid = totalPaid == 0 ? 0.1 : totalPaid;
      double adjustRemaining = remainingAmount == 0 ? 0.1 : remainingAmount;
      // totalInstallmentsSum += totalAmount == 0 ? 0.1 : totalAmount;
      // totalPaidSum += totalPaid == 0 ? 0.1 : totalPaid;
      barData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: adjustedTotalPaid,
              color: Colors.blue,
              width: 15,
              borderRadius: BorderRadius.circular(3),
            ),
            BarChartRodData(
              toY: adjustRemaining,
              color: Colors.orange,
              width: 15,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      );
    }
    return barData;
  }

  List<BarChartGroupData> getTotalBarData(
      List<CreditorInstallmentModel> installments) {
    double totalPaidSum =
        installments.fold(0, (sum, installment) => sum + installment.totalPaid);
    double totalInstallmentsSum = installments.fold(
        0, (sum, installment) => sum + installment.totalAmount);
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: totalPaidSum,
            color: Colors.green,
            width: 30,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: totalInstallmentsSum,
            color: Colors.red,
            width: 30,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    ];
  }

  List<String> getInstallmentNames(
      List<CreditorInstallmentModel> installments) {
    return installments
        .map((installment) => installment.installmentDebtor)
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedFilter = S.of(context).Uncompleted_Install;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditorInstallmentCubit, CreditorInstallmentState>(
      builder: (context, state) {
        if (state is CreditorInstallmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CreditorInstallmentLoaded) {
          final installments =
              selectedFilter == S.of(context).Uncompleted_Install
                  ? BlocProvider.of<CreditorInstallmentCubit>(context)
                      .allInstallments!
                  : BlocProvider.of<CreditorInstallmentCubit>(context)
                      .completedInstallment;
          final allInstallments =
              BlocProvider.of<CreditorInstallmentCubit>(context)
                  .allInstallments!;
          return CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).graph_title),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                        items: <String>[
                          S.of(context).Uncompleted_Install,
                          S.of(context).completed_Install,
                          S.of(context).total,
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppStyles.textStyle18black,
                            ),
                          );
                        }).toList(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedFilter == S.of(context).total
                            ? [
                                ChartExplainWidget(
                                  title: S.of(context).total_inflow,
                                  color: Colors.green,
                                ),
                                ChartExplainWidget(
                                  title: S.of(context).total_outflow,
                                  color: Colors.red,
                                ),
                              ]
                            : [
                                ChartExplainWidget(
                                  title: S.of(context).amount_paid,
                                  color: Colors.blue,
                                ),
                                ChartExplainWidget(
                                  title: S.of(context).remaining_amount,
                                  color: Colors.orange,
                                ),
                              ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              int index = value.toInt();
                              if (selectedFilter == S.of(context).total) {
                                return Text(
                                  index == 0
                                      ? S.of(context).total_inflow
                                      : S.of(context).total_outflow,
                                  style: AppStyles.textStyle18black,
                                );
                              } else if (index >= 0 &&
                                  index < installments.length) {
                                return Text(
                                  getInstallmentNames(installments)[index],
                                  style: AppStyles.textStyle18black,
                                );
                              } else {
                                return const Text('');
                              }
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: selectedFilter == S.of(context).total
                          ? getTotalBarData(allInstallments)
                          : getBarData(installments),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('No Data Available'));
        }
      },
    );
  }
}

class ChartExplainWidget extends StatelessWidget {
  final String title;
  final Color color;
  const ChartExplainWidget(
      {super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(color: color),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppStyles.textStyle18black,
        ),
      ],
    );
  }
}
