/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPAxisTickerTime : public QCPAxisTicker
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum TimeUnit { tuMilliseconds ///< Milliseconds, one thousandth of a second (%%z in \ref setTimeFormat)
                  ,tuSeconds     ///< Seconds (%%s in \ref setTimeFormat)
                  ,tuMinutes     ///< Minutes (%%m in \ref setTimeFormat)
                  ,tuHours       ///< Hours (%%h in \ref setTimeFormat)
                  ,tuDays        ///< Days (%%d in \ref setTimeFormat)
                };

  QCPAxisTickerTime();

  // getters:
  QString timeFormat();
  int fieldWidth(TimeUnit unit);

  // setters:
  void setTimeFormat(const QString &format);
  void setFieldWidth(TimeUnit unit, int width);

protected:
  // reimplemented virtual methods:
  virtual double getTickStep(const QCPRange &range);
  virtual int getSubTickCount(double tickStep);
  virtual QString getTickLabel(double tick, const QLocale &locale, QChar formatChar, int precision);

  // non-virtual methods:
  void replaceUnit(QString &text, TimeUnit unit, int value) const;
};
