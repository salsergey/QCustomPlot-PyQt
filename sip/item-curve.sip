/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemCurve : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-curve.h>
%End
public:
  explicit QCPItemCurve(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemCurve();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  QCPLineEnding head() const;
  QCPLineEnding tail() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setHead(const QCPLineEnding &head);
  void setTail(const QCPLineEnding &tail);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * start /NoSetter/;
  QCPItemPosition * startDir /NoSetter/;
  QCPItemPosition * endDir /NoSetter/;
  QCPItemPosition * end /NoSetter/;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);

  // non-virtual methods:
  QPen mainPen() const;
};
