/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPAxisTickerLog : public QCPAxisTicker
{
%TypeHeaderCode
#include <QCustomPlot/src/axis/axistickerlog.h>
%End
public:
  QCPAxisTickerLog();
  
  // getters:
  double logBase() const;
  int subTickCount() const;
  
  // setters:
  void setLogBase(double base);
  void setSubTickCount(int subTicks);

protected:
  // reimplemented virtual methods:
  virtual double getTickStep(const QCPRange &range);
  virtual int getSubTickCount(double tickStep);
  virtual QVector<double> createTickVector(double tickStep, const QCPRange &range);
};
